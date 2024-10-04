import 'package:flutter/material.dart';
import 'package:minddy/system/files/document_directory.dart';
import 'package:minddy/system/files/pick_files.dart';
import 'package:minddy/system/interfaces/document_directory_interface.dart';
import 'package:minddy/system/interfaces/file_picker_interface.dart';
import 'package:minddy/system/model/project_info.dart';

class StaticVariables {
  static IDocumentsDirectory get fileSource => _fileSource;
  
  static IFilesPicker get filePicker => _filesPicker;

  static ProjectInfo? currentProjectInfo;
  
  @protected
  static final IDocumentsDirectory _fileSource = AppDocumentsDirectory();

  @protected
  static final IFilesPicker _filesPicker = FilesPicker();
}