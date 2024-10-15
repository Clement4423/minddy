import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/utils/color_spaces_permutations.dart';
import 'package:minddy/ui/components/custom_components/custom_color_picker/custom_color_picker_input.dart';
import 'package:minddy/ui/components/custom_components/custom_color_picker/custom_color_picker_saturation_brightness.dart';
import 'package:minddy/ui/components/custom_components/custom_color_picker/custom_color_picker_hue_slider.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/theme/theme.dart';

Future<Color?> showColorPicker(BuildContext context, StylesGetters theme, {Color? initialColor, bool useOpacity = true}) async {
  Completer<Color?> completer = Completer<Color?>();

  showSubMenu(
    context, 
    isDismissible: true,
    dismissDirection: DismissDirection.none,
    CustomColorPicker(
      theme: theme, 
      useOpacity: useOpacity,
      initialColor: initialColor,
      onColorSelected: (color) {
        completer.complete(color);
      }
    )
  );

  return completer.future;
}

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({
    super.key,
    required this.theme,
    required this.onColorSelected,
    required this.useOpacity,
    this.initialColor
  });

  final StylesGetters theme;
  final Function(Color) onColorSelected;
  final Color? initialColor;
  final bool useOpacity;

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {

  double hue = 1.0;
  double saturation = 0.0;
  double brightness = 1.0;
  late Color selectedColor = HSLColor.fromAHSL(1.0, hue, saturation, brightness).toColor();

  CustomColorPickerInputColorMode mode = CustomColorPickerInputColorMode.hex;

  CustomColorPickerColorUpdater colorUpdater = CustomColorPickerColorUpdater();
  CustomColorPickerColorUpdater pickerUpdater = CustomColorPickerColorUpdater();

  void updateColor([bool notify = true]) {
    selectedColor = HSVColor.fromAHSV(1.0, hue, saturation, brightness).toColor();
    if (notify) {
      colorUpdater.notify();
    }
  }

  void inputChanged(HSLColor newColor) {
    setState(() {
      HSVColor hsv = hslToHsv(newColor);
      saturation = hsv.saturation;
      brightness = hsv.value;
      hue = hsv.hue;
      hsv.alpha;
      selectedColor = hsv.toColor();
    });
  }

  @override
  void initState() {
    if (widget.initialColor != null) {
      late HSVColor baseHsl = HSVColor.fromColor(widget.initialColor!);
      hue = baseHsl.hue;
      saturation = baseHsl.saturation;
      brightness = baseHsl.value;
      selectedColor = baseHsl.toColor();
    }
    super.initState();
  }

  @override
  void dispose() {
    colorUpdater.dispose();
    pickerUpdater.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 650,
      height: 295,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: widget.theme.primaryContainer,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 630,
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Selected color
                AnimatedBuilder(
                  animation: colorUpdater,
                  builder: (context, child) {
                    return Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                    );
                  }
                ),
                AnimatedBuilder(
                  animation: pickerUpdater,
                  builder: (context, child) {
                    return SaturationBrightnessBox(
                      key: UniqueKey(),
                      hue: hue,
                      saturation: saturation,
                      brightness: brightness,
                      width: 420,
                      height: 200,
                      theme: widget.theme,
                      onSaturationBrightnessChanged: (newSaturation, newBrightness) {
                        saturation = newSaturation;
                        brightness = newBrightness;
                        updateColor();
                      },
                    );
                  }
                ),
              ],
            ),
          ),
          // Hue slider
          CustomColorPickerHueSlider(
            key: UniqueKey(),
            width: 630,
            height: 25,
            hue: hue,
            theme: widget.theme,
            onHueChanged: (newHue) {
              hue = newHue;
              pickerUpdater.notify();
              updateColor();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedBuilder(
                animation: colorUpdater,
                builder: (context, child) {
                  return CustomColorPickerInput(
                    key: UniqueKey(),
                    theme: widget.theme, 
                    hslColor: HSLColor.fromColor(selectedColor),
                    onColorChanged: inputChanged,
                    mode: mode,
                    useOpacity: widget.useOpacity,
                    setMode: (newMode) {
                      setState(() {
                        mode = newMode;
                      });
                    } 
                  );
                }
              ),
              Container(
                width: 100,
                height: 30,
                margin: const EdgeInsets.only(right: 10),
                child: CustomTextButton(
                  S.of(context).submenu_artilces_image_description_button, 
                  () async {
                    Navigator.pop(context);
                    await widget.onColorSelected(selectedColor);
                  }, 
                  false, 
                  false
                ),
              )
            ]
          )
        ],
      ),
    );
  }
}

class CustomColorPickerColorUpdater extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}