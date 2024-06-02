import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:minddy/system/articles/app_articles.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';

class AppImages {
  static Future<Image?> getImage(String imageName) async {
    String documentDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();
    String imagePath = "$documentDirectoryPath/ressources/images/$imageName";
    File imageFile = File(imagePath);
    if (imageFile.existsSync()) {
      return Image.file(
        imageFile, 
        fit: BoxFit.contain,
      );
    } else {
      return null;
    }
  }

  static Future<String?> pickImage() async {
    List<String?>? result = await StaticVariables.filePicker.pickFiles(allowMultiplesFiles: false, fileType: FileType.image);
    if (result != null && result.first is String) {
      File file = File(result.first ?? "");

      final String generatedFileName = AppArticles.createFileName(file.path.split(r'/').last);
      final String finalFileName = "$generatedFileName.${file.path.split(r'/').last.split(r'.').last}";

      
      bool? savedFile = await saveImage(file.path, generatedFileName);

      if (savedFile) {
        return finalFileName;
      } else {
        return null;
      }
    }
    return null;
  }


  static Future<bool> saveImage(String imagePath, String imageName) async {
    try {
      final String appDocumentsDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();
      Directory ressourcesImageDirectory = Directory("$appDocumentsDirectoryPath/ressources/images");

      if (!ressourcesImageDirectory.existsSync()) {
        await StaticVariables.fileSource.createFolder("ressources/images");
      }

      await StaticVariables.filePicker.saveFile(actualFilePath: imagePath, newFileParentFolderPath: "ressources/images", newFileName: imageName);

      return true;
    } catch(e) {
      await AppLogs.writeError(e, "app_images - _saveImage");
      return false;
    }
  }
}