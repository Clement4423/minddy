import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/custom_table_cell_data_interface.dart';
import 'package:minddy/system/utils/launch_url.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class CustomTableUrlCell extends StatefulWidget implements ICustomTableCellData {
  CustomTableUrlCell({super.key, required this.theme, required this.initialValue}) {
    data = initialValue;
  }

  @override
  State<CustomTableUrlCell> createState() => _CustomTableUrlCellState();

  String initialValue;
  
  @override
  var data = 0;

  StylesGetters theme;
}

class _CustomTableUrlCellState extends State<CustomTableUrlCell> {

  bool showEditor = false;
  bool isHovering = false;

  @override
  void initState() {
    if (widget.data as String == '') {
      showEditor = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        if (!showEditor) {
          setState(() {
            isHovering = true;
          });
        }
      },
      onExit: (event) {
        if (!showEditor) {
          setState(() {
            isHovering = false;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Stack(
          children: [
            if (showEditor)
              TextField(
                onChanged: (value) {
                  widget.data = value;
                },
                onEditingComplete: () {
                  if (widget.data as String != '') {
                    setState(() {
                      showEditor = false;
                    });
                  }
                },
                controller: TextEditingController(text: widget.data),
                style: widget.theme.bodyMedium
                .copyWith(color: widget.theme.secondary, decoration: TextDecoration.underline, decorationColor: widget.theme.secondary),
                cursorColor: widget.theme.onSurface,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              )
            else if (showEditor == false && widget.data as String != '')
              Center(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      await launchURL(widget.data);
                    },
                    child: Tooltip(
                      message: S.of(context).projetcs_module_spreadsheet_open_website(getDomain(widget.data)),
                      waitDuration: const Duration(seconds: 1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: 30,
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                        margin: EdgeInsets.only(right: isHovering ? 55 : 8,),
                        decoration: BoxDecoration(
                          color: widget.theme.secondary,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(getDomain(widget.data), style: widget.theme.titleSmall
                                  .copyWith(fontWeight: FontWeight.w600, color: widget.theme.onSecondary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_outward_rounded, color: widget.theme.onSecondary, size: 20)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (isHovering && showEditor == false)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: isHovering ? 0.8 : 0.9,
                    end: isHovering ? 0.9 : 0.8,
                  ),
                  duration: const Duration(milliseconds: 100),
                  builder: (context, size, child) {
                    return Transform.scale(
                      scale: size,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            showEditor = true;
                          });
                        },
                        tooltip: S.of(context).projects_module_notes_modify_category,
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(widget.theme.primary),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
                          elevation: const WidgetStatePropertyAll(8),
                        ),
                        icon: Icon(Icons.brush_rounded, color: widget.theme.onPrimary),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}