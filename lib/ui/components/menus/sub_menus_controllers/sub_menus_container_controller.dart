import 'package:flutter/material.dart';

class SubMenuContainerController extends ChangeNotifier{
  final Widget _child;
  SubMenuContainerController(this._child);

  Widget get child => _child;
}