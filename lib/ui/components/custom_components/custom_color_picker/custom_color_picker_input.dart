import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/system/utils/color_spaces_permutations.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomColorPickerInput extends StatefulWidget {
  const CustomColorPickerInput({
    super.key,
    required this.theme,
    required this.hslColor,
    required this.onColorChanged,
    required this.mode,
    required this.setMode,
    required this.useOpacity
  });

  final StylesGetters theme;
  final HSLColor hslColor;
  final Function(HSLColor) onColorChanged;
  final CustomColorPickerInputColorMode mode;
  final Function(CustomColorPickerInputColorMode) setMode;
  final bool useOpacity;

  @override
  State<CustomColorPickerInput> createState() => _CustomColorPickerInputState();
}

enum CustomColorPickerInputColorMode {
  hex,
  rgb
}

class _CustomColorPickerInputState extends State<CustomColorPickerInput> {

  late HSLColor typedColor = widget.hslColor;

  late String hex = hslToHex(typedColor);

  late String r = typedColor.toColor().red.toStringAsFixed(0);
  late String g = typedColor.toColor().green.toStringAsFixed(0);
  late String b = typedColor.toColor().blue.toStringAsFixed(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.mode == CustomColorPickerInputColorMode.hex 
        ? 225 
        : 325,
      height: 30,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: widget.theme.primary,
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          selectionColor: widget.theme.secondary.withOpacity(0.5)
        ),
        child: Row(
          children: [
            // HSL or RGB Selector
            Container(
              width: 65,
              height: 30,
              margin: const EdgeInsets.only(left: 10),
              child: CustomSelectionMenu(
                theme: widget.theme,
                buttonStyle: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  elevation: WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                ),
                items: [
                  CustomSelectionMenuItem(
                    label: "HEX", 
                    icon: null, 
                    onTap: () {
                      setState(() {
                        widget.setMode(CustomColorPickerInputColorMode.hex);
                      });
                    }
                  ),
                  CustomSelectionMenuItem(
                    label: "RGB", 
                    icon: null, 
                    onTap: () {
                      setState(() {
                        widget.setMode(CustomColorPickerInputColorMode.rgb);
                      });
                    }
                  )
                ],
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.mode.name.toUpperCase(),
                        style: widget.theme.bodyMedium
                        .copyWith(color: widget.theme.onPrimary),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      color: widget.theme.onPrimary
                    )
                  ],
                )
              ),
            ),
            // Separator
            Container(
              width: 1,
              height: 20,
              decoration: BoxDecoration(
                color: widget.theme.onPrimary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(1)
              ),
            ),
            // Value.s
            if (widget.mode == CustomColorPickerInputColorMode.hex)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 75,
                  height: 30,
                  child: TextField(
                    onChanged: (value) {
                      hex = value;
                    },
                    onEditingComplete: () {
                      if (hex.isEmpty) {
                        hex = 'FFFFFF';
                      }
                      
                      if (hex.length < 3) {
                        if (hex.length == 2) {
                          hex = hex.padRight(6, hex);
                        } else if (hex.length == 1) {
                          hex = hex.padRight(6, hex);
                        }
                      } else if (hex.length == 7) {
                        String startHex = hex.substring(7);
                        hex = startHex.padRight(8, hex);
                      }
                                            
                      hex = hex.padRight(6, '0');

                      if (!widget.useOpacity) {
                        hex = hex.substring(0, 6);
                      }
                      typedColor = hexToHsl(hex);
                      widget.onColorChanged(typedColor);
                    },
                    controller: TextEditingController(text: hslToHex(widget.hslColor).toUpperCase().substring(0, 6)),
                    cursorColor: widget.theme.onPrimary,
                    cursorHeight: 20,
                    style: widget.theme.bodyMedium
                      .copyWith(color: widget.theme.onPrimary),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-fA-F0-9]'))
                    ],
                    maxLines: 1,
                    maxLength: 8,
                    buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
                      return const SizedBox.shrink();
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'FFFFFF',
                      hintStyle: widget.theme.bodyMedium
                        .copyWith(color: widget.theme.onPrimary.withOpacity(0.5)),
                      contentPadding: const EdgeInsets.only(bottom: 15),
                    ),
                  ),
                ),
              )
            else if (widget.mode == CustomColorPickerInputColorMode.rgb)
              ...[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 50,
                    height: 30,
                    child: TextField(
                      controller: TextEditingController(text: r),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          r = int.parse(value).clamp(0, 255).toString();
                          typedColor = HSLColor.fromColor(Color.fromARGB(255, int.parse(r), int.parse(g), int.parse(b)));
                        }
                      },
                      onEditingComplete: () {
                        widget.onColorChanged(typedColor);
                      },
                      cursorColor: widget.theme.onPrimary,
                      cursorHeight: 20,
                      style: widget.theme.bodyMedium
                        .copyWith(color: widget.theme.onPrimary),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      maxLines: 1,
                      maxLength: 3,
                      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
                        return const SizedBox.shrink();
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixText: 'R ',
                        prefixStyle: widget.theme.bodyMedium
                          .copyWith(color: widget.theme.onPrimary.withOpacity(0.7)),
                        hintText: '255',
                        hintStyle: widget.theme.bodyMedium
                          .copyWith(color: widget.theme.onPrimary.withOpacity(0.5)),
                        contentPadding: const EdgeInsets.only(bottom: 15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 50,
                    height: 30,
                    child: TextField(
                      controller: TextEditingController(text: g),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          g = int.parse(value).clamp(0, 255).toString();
                          typedColor = HSLColor.fromColor(Color.fromARGB(255, int.parse(r), int.parse(g), int.parse(b)));
                        }
                      },
                      onEditingComplete: () {
                        widget.onColorChanged(typedColor);
                      },
                      cursorColor: widget.theme.onPrimary,
                      cursorHeight: 20,
                      style: widget.theme.bodyMedium
                        .copyWith(color: widget.theme.onPrimary),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      maxLines: 1,
                      maxLength: 3,
                      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
                        return const SizedBox.shrink();
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixText: 'G ',
                        prefixStyle: widget.theme.bodyMedium
                          .copyWith(color: widget.theme.onPrimary.withOpacity(0.7)),
                        hintText: '255',
                        hintStyle: widget.theme.bodyMedium
                          .copyWith(color: widget.theme.onPrimary.withOpacity(0.5)),
                        contentPadding: const EdgeInsets.only(bottom: 15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 50,
                    height: 30,
                    child: TextField(
                      controller: TextEditingController(text: b),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          b = int.parse(value).clamp(0, 255).toString();
                          typedColor = HSLColor.fromColor(Color.fromARGB(255, int.parse(r), int.parse(g), int.parse(b)));
                        }
                      },
                      onEditingComplete: () {
                        widget.onColorChanged(typedColor);
                      },
                      cursorColor: widget.theme.onPrimary,
                      cursorHeight: 20,
                      style: widget.theme.bodyMedium
                        .copyWith(color: widget.theme.onPrimary),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      maxLines: 1,
                      maxLength: 3,
                      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
                        return const SizedBox.shrink();
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixText: 'B ',
                        prefixStyle: widget.theme.bodyMedium
                          .copyWith(color: widget.theme.onPrimary.withOpacity(0.7)),
                        hintText: '255',
                        hintStyle: widget.theme.bodyMedium
                          .copyWith(color: widget.theme.onPrimary.withOpacity(0.5)),
                        contentPadding: const EdgeInsets.only(bottom: 15),
                      ),
                    ),
                  ),
                )
              ],
            // Separator
            Container(
              width: 1,
              height: 20,
              decoration: BoxDecoration(
                color: widget.theme.onPrimary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(1)
              ),
            ),
            // Value.s
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 45,
                  height: 30,
                  child: Tooltip(
                    message: "Opacity",
                    waitDuration: const Duration(seconds: 1),
                    child: TextField(
                      key: UniqueKey(),
                      controller: TextEditingController(text: (typedColor.alpha * 100).toStringAsFixed(0)),
                      onChanged: (value) {
                        if (widget.useOpacity) {
                          if (value.isEmpty) {
                            value = "100";
                          }
                          print("ALPHA ${(num.parse(value) / 100).clamp(0.0, 1.0)}");
                          typedColor = typedColor.withAlpha((num.parse(value) / 100).clamp(0.0, 1.0));
                        }
                      },
                      onEditingComplete: () {
                        widget.onColorChanged(typedColor);
                      },
                      cursorColor: widget.theme.onPrimary,
                      cursorHeight: 20,
                      style: widget.theme.bodyMedium
                        .copyWith(color: widget.theme.onPrimary.withOpacity(widget.useOpacity ? 1.0 : 0.5)),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      maxLines: 1,
                      maxLength: 3,
                      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
                        return const SizedBox.shrink();
                      },
                      textAlign: TextAlign.end,
                      mouseCursor: widget.useOpacity 
                        ? SystemMouseCursors.text
                        : SystemMouseCursors.basic,
                      readOnly: !widget.useOpacity,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '100',
                        hintStyle: widget.theme.bodyMedium
                          .copyWith(color: widget.theme.onPrimary.withOpacity(0.5)),
                        contentPadding: const EdgeInsets.only(bottom: 15),
                        suffixText: '%',
                        suffixStyle: widget.theme.bodyMedium
                          .copyWith(color: widget.theme.onPrimary.withOpacity(widget.useOpacity ? 1.0 : 0.5)),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
