import 'dart:convert';
import 'dart:io';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/system/files/encryption.dart';
import 'package:minddy/system/interfaces/document_directory_interface.dart';
import 'package:path/path.dart' as path;
import 'package:minddy/system/files/app_logs.dart';
import 'package:path_provider/path_provider.dart';

class AppDocumentsDirectory implements IDocumentsDirectory{
  @override
  Future<bool> writeJsonFile(String fileRelativePath, Map<String, dynamic> content,  {bool encrypt = true}) async {
    try {
      File file = await _getCompletePath(fileRelativePath);
      if (await file.exists()) {
        final encodedData = jsonEncode(content);

        if (encrypt) {
          String? encryptedData = await AppEncrypter.encryptData(encodedData);
          if (encryptedData != null) {
            await file.writeAsString(encryptedData);
            return true;
          } else {
            throw Exception("Impossible to encrypt data");
          }
        }

        await file.writeAsString(encodedData);
        return true;
      }
      return false;
    } catch (e) {
      await AppLogs.writeError("$e - CONCERNED DATA WAS : $content", "files.dart - writeJsonFile");
      return false;
    }
  }


  @override
  Future<Map<String, dynamic>?> readJsonFile(String fileRelativePath,  {bool decrypt = true}) async {
    String debugContent = "";
    try {
      File file = await _getCompletePath(fileRelativePath);

      if (await file.exists()) {
        String fileContent = await file.readAsString();

        if (decrypt) {
          String? decryptedData = await AppEncrypter.decryptData(fileContent);
          if (decryptedData != null) {
            debugContent = decryptedData;
            Map<String, dynamic>? decodedFileContent = await jsonDecode(decryptedData);
            return decodedFileContent;
          } else {
            throw Exception("Impossible to decrypt data");
          }
        }

        debugContent = fileContent;
        Map<String, dynamic>? decodedFileContent = await jsonDecode(fileContent);

        return decodedFileContent;
      } else {
        await AppLogs.writeError("Tried to read a non existing file, path was : ${file.path}", "document_directory.dart - readJsonFile");
        return null;
      }
    } catch(e) {
      await AppLogs.writeError("$e CONCERNED DATA WAS $debugContent", "files.dart - readJsonFile");
      return null;
    }
  }

 @override
  Future<bool> createFile(String fileRelativePath) async {
    try {
      File file = await _getCompletePath(fileRelativePath);
      if (await file.exists()) {
        await AppLogs.writeError("The file at $fileRelativePath already exists", "files.dart - createFile");
        return false;
      } else {
        await file.create(recursive: true);
        return true;
      }
    } catch (e) {
      await AppLogs.writeError(e, "files.dart");
      return false;
    }
  }

  @override
  Future<bool> createFolder(String folderRelativePath) async {
    try {
      String documentDirectoryPath = await getAppDirectoryPath();
      Directory folder = Directory("$documentDirectoryPath/$folderRelativePath");

      if (await folder.exists()) {
        await AppLogs.writeError("The folder at $folderRelativePath already exists", "files.dart - createFolder");
        return false;
      } else {
        await folder.create(recursive: true);
        return true;
      }
    } catch (e) {
      await AppLogs.writeError(e.toString(), "files.dart - createFolder");
      return false;
    }
  }

  @override
  Future<bool> removeFile(String fileRelativePath) async {
    try {
      File file = await _getCompletePath(fileRelativePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      } else {
        await AppLogs.writeError("Tried to delete an non-existing file", "files.dart - removeFile");
        return false;
      }
    } catch (e) {
      await AppLogs.writeError(e, "files.dart - removeFolder");
      return false;
    }
  }

  @override
  Future<bool> removeFolder(String folderRelativePath) async {
    try {
      String documentDirectoryPath = await getAppDirectoryPath();
      Directory folder = Directory("$documentDirectoryPath/$folderRelativePath");
      if (await folder.exists()) {
        await folder.delete(recursive: true);
        return true;
      } else {
        await AppLogs.writeError("Tried to delete an non-existing folder", "files.dart - removeFolder");
        return false;
      }
    } catch (e) {
      await AppLogs.writeError(e, "files.dart - removeFolder");
      return false;
    }
  }

  @override
  Future<Directory?> duplicateFolder(String folderToDuplicatePath, String destinationPath) async {
    try {
      String documentDirectoryPath = await getAppDirectoryPath();
      Directory originalFolder = Directory("$documentDirectoryPath/$folderToDuplicatePath");
      if (await originalFolder.exists()) {

        String newFolderName = createUniqueId().toString();

        Directory copyFolder = Directory("$documentDirectoryPath/$destinationPath/$newFolderName");
        await copyFolder.create();

        await _copyFolderContent(originalFolder, copyFolder);

        return copyFolder;
      } else {
        await AppLogs.writeError("Tried to duplicate a non-existing folder", "files.dart - duplicateFolder");
        return null;
      }
    } catch (e) {
      await AppLogs.writeError(e, "files.dart - duplicateFolder");
      return null;
    }
  }

  @override
  Future<bool> renameFolder(String folderRelativePath, String newName) async {
    try {
      String documentDirectoryPath = await getAppDirectoryPath();
      Directory folder = Directory("$documentDirectoryPath/$folderRelativePath");
      
      if (await folder.exists()) {
        String newFolderPath = path.join(documentDirectoryPath, path.dirname(folderRelativePath), newName);
        await folder.rename(newFolderPath);
        return true;
      } else {
        await AppLogs.writeError("Folder does not exist.", "files.dart - renameFolder");
        return false;
      }
    } catch (e) {
      await AppLogs.writeError(e, "files.dart - renameFolder");
      return false;
    }
  }

  @override
  Future<bool> renameFile(String fileRelativePath, String newName) async {
    try {
      String documentDirectoryPath = await getAppDirectoryPath();
      File file = File("$documentDirectoryPath/$fileRelativePath");
      if (await file.exists()) {
        String directoryPath = path.dirname(fileRelativePath);
        String newFilePath = path.join(documentDirectoryPath, directoryPath, newName);
        await file.rename(newFilePath);
        return true;
      } else {
        await AppLogs.writeError("File does not exist.", "files.dart - renameFile");
        return false;
      }
    } catch (e) {
      await AppLogs.writeError(e, "files.dart - renameFile");
      return false;
    }
  }


  Future<void> _copyFolderContent(Directory source, Directory destination) async {
    List<FileSystemEntity> contents = source.listSync(recursive: false);
    for (FileSystemEntity content in contents) {
      String newPath = content.path.replaceFirst(source.path, destination.path);
      if (content is File) {
        await content.copy(newPath);
      } else if (content is Directory) {
        await Directory(newPath).create(recursive: true);
        await _copyFolderContent(content, Directory(newPath));
      }
    }
  }

  Future<File> _getCompletePath(String fileRelativePath) async {
    String documentDirectoryPath = await getAppDirectoryPath();
    String completePath = '$documentDirectoryPath/$fileRelativePath';
    if (Platform.isWindows) {
      completePath = completePath.replaceAll(r'[/]', r'\');
    }
    File file = File(completePath);
    return file;
  }

  @override
  Future<String> getAppDirectoryPath() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    return "${documentDirectory.path}/minddy";
  }
  
  @override
  late String documentDirectoryPath;
}
