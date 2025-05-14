import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/plugin_ui_component_properties_interface.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';

String getFontFamilyFromTextFontName(TextFontName selected) {
  switch (selected) {
    case TextFontName.montserrat:
      return 'Montserrat';
  }
}

TextAlign getTextAligntFromTextAlignment(TextAlignment selected) {
  switch (selected) {
    case TextAlignment.start:
      return TextAlign.start;
    case TextAlignment.center:
      return TextAlign.center;
    case TextAlignment.end:
      return TextAlign.end;
    case TextAlignment.justify:
      return TextAlign.justify;
  }
}

FontWeight getFontWeightForTextFontWeight(TextFontWeight selected) {
  switch (selected) {
    case TextFontWeight.thin:
      return FontWeight.w100;
    case TextFontWeight.extraLight:
      return FontWeight.w200;
    case TextFontWeight.light:
      return FontWeight.w300;
    case TextFontWeight.regular:
      return FontWeight.w400;
    case TextFontWeight.medium:
      return FontWeight.w500;
    case TextFontWeight.semiBold:
      return FontWeight.w600;
    case TextFontWeight.bold:
      return FontWeight.w700;
    case TextFontWeight.extraBold:
      return FontWeight.w800;
    case TextFontWeight.black:
      return FontWeight.w900;
  }
}

class PluginUiComponentText implements IPluginUiComponent {

  PluginUiComponentText({required this.properties});

  @override
  int id = createUniqueId();

  @override
  String name = 'Text'; // TODO : Traduire

  @override
  final PluginUiComponentTextProperties properties;

  @override
  PluginUiComponentType type = PluginUiComponentType.basicComponent;

  @override
  List<IPluginUiComponent> child = [];

  @override
  Widget preview(List<Widget> childsToShow) {
    return OverflowAwareText(
      width: properties.width,
      height: properties.height,
      text: properties.text,
      maxLines: properties.maxLines.clamp(1, 100000),
      textAlign: getTextAligntFromTextAlignment(properties.textAlignment),
      style: TextStyle(
        letterSpacing: properties.letterSpacing,
        wordSpacing: properties.wordSpacing,
        color: IPluginUiComponentProperties.colorFromText(properties.color),
        fontFamily: getFontFamilyFromTextFontName(properties.fontName),
        fontSize: properties.fontSize,
        decoration: properties.underline ? TextDecoration.underline : null,
        fontWeight: getFontWeightForTextFontWeight(properties.fontWeight)
      ),
    );
  }

  Widget _buildWidget() {
    return OverflowAwareText(
      width: properties.width,
      height: properties.height,
      text: properties.text,
      maxLines: properties.maxLines.clamp(1, 100000),
      style: TextStyle(
        letterSpacing: properties.letterSpacing,
        wordSpacing: properties.wordSpacing,
        color: IPluginUiComponentProperties.colorFromText(properties.color),
        fontFamily: getFontFamilyFromTextFontName(properties.fontName),
        fontSize: properties.fontSize,
        decoration: properties.underline ? TextDecoration.underline : null,
        fontWeight: getFontWeightForTextFontWeight(properties.fontWeight)
      ),
    );
  }

  @override
  Widget get widget => _buildWidget();

  @override
  String toJson() {
    return jsonEncode({
      'type': runtimeType.toString(),
      'id': id,
      'name': name,
      'properties': properties.toJson(),
      'child': child.map((c) => c.toJson()).toList()
    });
  }

  static PluginUiComponentText? fromJson(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      PluginUiComponentTextProperties? properties = PluginUiComponentTextProperties.fromJson(map['properties']);

      if (properties != null) {
        return PluginUiComponentText(properties: properties)
          ..id = map['id']
          ..name = map['name']
          ..child = (map['child'] as List).map((c) {
            return IPluginUiComponent.fromJson(c)!;
          }).toList();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  
  @override
  set properties(IPluginUiComponentProperties newProperty) {}
  
  @override
  set widget(Widget newWidget) {}
}

enum TextFontWeight {
  thin,
  extraLight,
  light,
  regular,
  medium,
  semiBold,
  bold,
  extraBold,
  black,
}

enum TextFontName {
  montserrat
}

enum TextAlignment {
  start, 
  center, 
  end,
  justify
}

class PluginUiComponentTextProperties implements IPluginUiComponentProperties {
  double width;
  double height;
  String text;
  int maxLines;
  TextFontWeight fontWeight;
  double fontSize;
  TextFontName fontName;
  double letterSpacing;
  double wordSpacing;
  TextAlignment textAlignment;
  String color;
  bool underline;

  PluginUiComponentTextProperties({
    required this.width, 
    required this.height, 
    required this.text, 
    required this.maxLines,
    required this.fontName,
    required this.fontSize,
    required this.fontWeight,
    required this.letterSpacing,
    required this.wordSpacing,
    required this.textAlignment,
    required this.color,
    required this.underline
  });

  @override
  String toJson() {
    return jsonEncode({
      'width': width,
      'height': height,
      'text': text,
      'max_lines': maxLines,
      'font_name': fontName.index,
      'font_size': fontSize,
      'font_weight': fontWeight.index,
      'word_spacing': wordSpacing,
      'letter_spacing': letterSpacing,
      'text_alignment': textAlignment.index,
      'color': color,
      'underline': underline
    });
  }

  static PluginUiComponentTextProperties? fromJson(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      return PluginUiComponentTextProperties(
        width: map['width'], 
        height: map['height'], 
        text: map['text'],
        maxLines: map['max_lines'],
        fontName: TextFontName.values[map['font_name']],
        fontSize: map['font_size'],
        fontWeight: TextFontWeight.values[map['font_weight']],
        letterSpacing: map['letter_spacing'],
        wordSpacing: map['word_spacing'],
        textAlignment: TextAlignment.values[map['text_alignment']],
        color: map['color'],
        underline: map['underline']
      ); 
    } catch (e) {
      return null;
    }
  }
}

class OverflowAwareText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double width;
  final double height;
  final TextAlign textAlign;
  final int maxLines;

  const OverflowAwareText({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? DefaultTextStyle.of(context).style;

    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width);

    final bool isOverflowing = textPainter.didExceedMaxLines;

    return CustomTooltip(
      message: isOverflowing ? text : '',
      child: SizedBox(
        width: width,
        height: height,
        child: Text(
          text,
          style: textStyle,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: isOverflowing ? TextOverflow.ellipsis : TextOverflow.visible,
        ),
      ),
    );
  }
}