import 'dart:convert';

class BorderAlignment {
  List<int> sides;

  BorderAlignment({required this.sides});

  String toJson() {
    return jsonEncode(sides);
  }

  static BorderAlignment base() {
    return BorderAlignment(sides: []);
  } 

  static BorderAlignment? fromJson(String json) {
    try {
      List<dynamic> list = jsonDecode(json);

      return BorderAlignment(sides: list.map((e) => int.parse(e.toString())).toList()); // To convert it to a list<int> and not list<dynamic>
    } catch (e) {
      return null;
    }
  } 
}