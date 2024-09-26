import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ShortcutActivator escapeActivator = const SingleActivator(LogicalKeyboardKey.escape);

class EscapeIntent extends Intent {
  const EscapeIntent();
}

ShortcutActivator saveActivator = SingleActivator(
  LogicalKeyboardKey.keyS, 
  meta: Platform.isMacOS 
    ? true 
    : false,
  control: Platform.isWindows || Platform.isLinux
    ? true
    : false
);

class SaveIntent extends Intent {
  const SaveIntent();
}

ShortcutActivator nextPageActivator = SingleActivator(
  LogicalKeyboardKey.arrowRight, 
  meta: Platform.isMacOS 
    ? true 
    : false,
  control: Platform.isWindows || Platform.isLinux
    ? true
    : false
);

class NextPageIntent extends Intent {
  const NextPageIntent();
}

ShortcutActivator previousPageActivator = SingleActivator(
  LogicalKeyboardKey.arrowLeft, 
  meta: Platform.isMacOS 
    ? true 
    : false,
  control: Platform.isWindows || Platform.isLinux
    ? true
    : false
);

class PreviousPageIntent extends Intent {
  const PreviousPageIntent();
}

ShortcutActivator deleteActivator = SingleActivator(
  LogicalKeyboardKey.backspace,
  control: Platform.isWindows || Platform.isLinux 
    ? true 
    : false,
  meta: Platform.isMacOS 
    ? true 
    : false
);

class DeletePressIntent extends Intent {
  const DeletePressIntent();
}

ShortcutActivator duplicateActivator = SingleActivator(
  LogicalKeyboardKey.keyD,
  control: Platform.isWindows || Platform.isLinux 
    ? true 
    : false,
  meta: Platform.isMacOS 
    ? true 
    : false
);

class DuplicatePressIntent extends Intent {
  const DuplicatePressIntent();
}

ShortcutActivator copyActivator = SingleActivator(
  LogicalKeyboardKey.keyC,
  control: Platform.isWindows || Platform.isLinux 
    ? true 
    : false,
  meta: Platform.isMacOS 
    ? true 
    : false
);

class CopyPressIntent extends Intent {
  const CopyPressIntent();
}

ShortcutActivator pasteActivator = SingleActivator(
  LogicalKeyboardKey.keyV,
  control: Platform.isWindows || Platform.isLinux 
    ? true 
    : false,
  meta: Platform.isMacOS 
    ? true 
    : false
);

class PastePressIntent extends Intent {
  const PastePressIntent();
}


ShortcutActivator undoActivator = SingleActivator(
  LogicalKeyboardKey.keyZ,
  control: Platform.isWindows || Platform.isLinux 
    ? true 
    : false,
  meta: Platform.isMacOS 
    ? true 
    : false
);

class UndoPressIntent extends Intent {
  const UndoPressIntent();
}

ShortcutActivator redoActivator = SingleActivator(
  LogicalKeyboardKey.keyZ,
  control: Platform.isWindows || Platform.isLinux 
    ? true 
    : false,
  meta: Platform.isMacOS 
    ? true 
    : false,
  shift: true
);

class RedoPressIntent extends Intent {
  const RedoPressIntent();
}
