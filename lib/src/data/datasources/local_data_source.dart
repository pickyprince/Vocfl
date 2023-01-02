import 'dart:convert';
import 'dart:io';
import '../../../../core/error/exceptions.dart';
import 'package:path_provider/path_provider.dart';

abstract class LocalDataSource {
  Future<List<Map<String, dynamic>>> readAllFilesFromLocalDataSource();
  Future<Map<String, dynamic>> readSingleFileByIdFromLocalDataSource(String id);
  Future<void> writeMultipleWordsSetsToLocalDataSource(
      Map<String, dynamic> json);
  Future<void> writeSingleWordsSetsToLocalDataSource(Map<String, dynamic> json);
  Future<void> deleteWordsSetByIdFromLocalDataSource(String id);
  Future<void> updateWordsSetById(Map<String, dynamic> json);
  Future<void> writeIniFile(Map<String, dynamic> json);
  Future<Map<String, dynamic>> readIniFile();
  Future<void> writeAnalysisDataFile(Map<String, dynamic> json);
  Future<Map<String, dynamic>> readAnalysisDataFile();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> deleteWordsSetByIdFromLocalDataSource(String id) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final appDir = await Directory("$appDocPath/vocfl").create();
    final appDirPath = appDir.path;

    await File("$appDirPath/$id.json").delete();
  }

  @override
  Future<List<Map<String, dynamic>>> readAllFilesFromLocalDataSource() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final appDir = await Directory("$appDocPath/vocfl").create();
    final _files = appDir.listSync().whereType<File>();
    List<Map<String, dynamic>> list = [];
    for (FileSystemEntity file in _files) {
      print(File(file.path).readAsString());
      list.add(jsonDecode(await File(file.path).readAsString()));
    }
    return list;
  }

  @override
  Future<Map<String, dynamic>> readSingleFileByIdFromLocalDataSource(
      String id) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    final appDir = await Directory("$appDocPath/vocfl").create();
    final appDirPath = appDir.path;
    return jsonDecode(await File("$appDirPath/$id.json").readAsString());
  }

  @override
  Future<void> updateWordsSetById(Map<String, dynamic> json) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    appDocDir.create();

    final appDir = await Directory("$appDocPath/vocfl").create();
    final appDirPath = appDir.path;
    final id = json['id'];
    await File("$appDirPath/$id.json").writeAsString(jsonEncode(json));
  }

  @override
  Future<void> writeMultipleWordsSetsToLocalDataSource(
      Map<String, dynamic> json) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    appDocDir.create();

    final appDir = await Directory("$appDocPath/vocfl").create();
    final appDirPath = appDir.path;
    var id = json['id'];
    File("$appDirPath/$id.json").writeAsString(jsonEncode(json));
  }

  @override
  Future<void> writeSingleWordsSetsToLocalDataSource(
      Map<String, dynamic> json) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    appDocDir.create();

    final appDir = await Directory("$appDocPath/vocfl").create();
    final appDirPath = appDir.path;
    final id = json['id'];
    await File("$appDirPath/$id.json").writeAsString(jsonEncode(json));
  }

  @override
  Future<Map<String, dynamic>> readIniFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    final appDir = await Directory("$appDocPath/settings").create();
    final appDirPath = appDir.path;
    return jsonDecode(await File("$appDirPath/ini.json").readAsString());
  }

  @override
  Future<void> writeIniFile(Map<String, dynamic> json) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    appDocDir.create();

    final appDir = await Directory("$appDocPath/settings").create();
    final appDirPath = appDir.path;
    final id = json['id'];
    await File("$appDirPath/ini.json").writeAsString(jsonEncode(json));
  }

  @override
  Future<Map<String, dynamic>> readAnalysisDataFile() async {
    var appDir;
    var appDirPath;
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      appDir = await Directory("$appDocPath/analysis").create();
      appDirPath = appDir.path;
    } on Exception {
      throw DirectoryException();
    }
    try {
      return jsonDecode(
          await File("$appDirPath/analysis_data.json").readAsString());
    } on Exception {
      throw FileReadException();
    }
  }

  @override
  Future<void> writeAnalysisDataFile(Map<String, dynamic> json) async {
    var appDir;
    var appDirPath;
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      appDocDir.create();
      appDir = await Directory("$appDocPath/analysis").create();
      appDirPath = appDir.path;
    } on Exception {
      throw DirectoryException();
    }
    try {
      await File("$appDirPath/analysis_data.json")
          .writeAsString(jsonEncode(json));
    } on Exception {
      throw FileWriteException();
    }
  }
}
