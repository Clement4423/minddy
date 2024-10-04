import 'package:file_picker/file_picker.dart';

abstract class IFilesPicker {
  Future<List<String?>?>pickFiles({List<String>? allowedExtensions, bool allowMultiplesFiles = false, FileType? fileType});
  Future<bool> saveFile({required String actualFilePath, required String newFileParentFolderPath, String? newFileName});
}