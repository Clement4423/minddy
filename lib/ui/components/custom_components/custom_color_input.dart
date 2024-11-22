import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/utils/color_spaces_permutations.dart';
import 'package:minddy/ui/components/custom_components/custom_color_picker/custom_color_picker.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomColorInput extends StatefulWidget {
  const CustomColorInput({
    super.key,
    required this.theme,
    required this.color,
    required this.onColorChanged,
    this.useOpacity = true
  });

  final StylesGetters theme;
  final Color color;
  final Function(Color) onColorChanged;
  final bool useOpacity;

  @override
  State<CustomColorInput> createState() => _CustomColorInputState();
}

class _CustomColorInputState extends State<CustomColorInput> {

  late Color color = widget.color;
  late HSLColor hslColor = HSLColor.fromColor(color);

  late String hex = hslToHex(hslColor).toUpperCase();

  void setHex(Color newColor) {
    hslColor = HSLColor.fromColor(newColor);
    hex = hslToHex(hslColor).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: widget.theme.surface,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          Tooltip(
            message: S.of(context).default_app_colors_change_color,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  Color? selectedColor = await showColorPicker(context, widget.theme, initialColor: color, useOpacity: widget.useOpacity);
                  if (selectedColor != null) {
                    setState(() {
                      color = selectedColor;
                      setHex(color);
                      widget.onColorChanged(color);
                    });
                  }
                },
                child: Container(
                  width: 35,
                  height: 35,
                  margin: const EdgeInsets.only(left: 7.5),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(7.5),
                  )
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: TextField(
                key: UniqueKey(),
                controller: TextEditingController(text: hex.substring(0, 6)),
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
                  
                  color = hexToHsl(hex).toColor();
                  widget.onColorChanged(color);
                  setState(() {});
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-fA-F0-9]'))
                ],
                maxLines: 1,
                maxLength: 8,
                buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
                  return const SizedBox.shrink();
                },
                cursorColor: widget.theme.onSurface,
                style: widget.theme.bodyMedium
                  .copyWith(color: widget.theme.onSurface),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "FFFFFF",
                  hintStyle: widget.theme.bodyMedium
                    .copyWith(color: widget.theme.onSurface.withOpacity(0.5))
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}