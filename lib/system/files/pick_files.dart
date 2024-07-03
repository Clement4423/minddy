import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:path/path.dart' as path;
import 'package:minddy/system/interface/file_picker_interface.dart';

class FilesPicker extends IFilesPicker {
  @override
  Future<List<String?>?> pickFiles({List<String>? allowedExtensions, bool allowMultiplesFiles = false, FileType? fileType}) async {
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiplesFiles, 
      allowedExtensions: allowedExtensions,
      type: fileType ?? FileType.any
     );

      if (result != null) {
        return result.paths;
      } 
      return null;
    } catch(e) {
      await AppLogs.writeError(e, "pick_files.dart - pickFiles");
      return null;
    }
  }

  /// Make sure that the destination path exists, otherwise the file will not be saved
  @override
  Future<bool> saveFile({required String actualFilePath, required String newFileParentFolderPath, String? newFileName}) async {
    try {
      final String fileExtension = path.extension(actualFilePath);
      
      late String finalFileName;


      if (newFileName != null) {
        String newFileNameExtension = path.extension(newFileName);

        newFileNameExtension == '' // If there is no extension, we add it. Otherwise, we let the default one.
        ? finalFileName = "$newFileName$fileExtension"
        : finalFileName = newFileName;
        
      } else {
        final String randomName = createUniqueId().toString();
        finalFileName = "$randomName$fileExtension";
      }

      final File newFile = File("${await StaticVariables.fileSource.getAppDirectoryPath()}/$newFileParentFolderPath/$finalFileName");

      File createdFile = await newFile.create(recursive: true);
      await File(actualFilePath).copy(createdFile.path);
      return true;
    } catch(e) {
      await AppLogs.writeError(e, "pick_files - _saveImage");
      return false;
    }
  }
}