import 'package:flutter/material.dart';
import 'package:minddy/system/interface/projects_modules_controller_interface.dart';

abstract class IProjectsModules extends Widget{
  late final double width;
  late final double height;
  late final Function(int) deleteFunction;
  late final Function(int) duplicateFunction;
  late final IProjectModuleController controller;

  // ignore: prefer_const_constructors_in_immutables
  IProjectsModules({super.key});
}