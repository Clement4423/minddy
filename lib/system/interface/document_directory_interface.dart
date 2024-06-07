import 'dart:io';

abstract class IDocumentsDirectory {
  String documentDirectoryPath = "";
  Future<bool> writeJsonFile(String fileRelativePath, Map<String, dynamic> content, {bool encrypt = true});
  Future<Map<String, dynamic>?> readJsonFile(String fileRelativePath, {bool decrypt = true});
  Future<bool> createFile(String fileRelativePath);
  Future<bool> removeFile(String fileRelativePath);
  Future<bool> removeFolder(String folderRelativePath);
  Future<bool> createFolder(String folderRelativePath);
  Future<Directory?> duplicateFolder(String folderToDuplicatePath, String destinationPath);
  Future<bool> renameFolder(String folderRelativePath, String newName);
  Future<bool> renameFile(String fileRelativePath, String newName);
  Future<String> getAppDirectoryPath();
}
