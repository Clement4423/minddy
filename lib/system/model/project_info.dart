import 'dart:ui';

class ProjectInfo {
  final String name;
  final bool isPrivate;
  final DateTime lastChanged;
  final Color color;
  final String path;

  ProjectInfo(this.name, this.isPrivate, this.color, this.lastChanged, this.path);
}
