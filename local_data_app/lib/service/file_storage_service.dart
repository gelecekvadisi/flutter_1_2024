import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_data_app/service/locale_storage_service.dart';
import 'package:path_provider/path_provider.dart';

import '../model/user_model.dart';

class FileStorageService extends LocaleStorageService{

  FileStorageService() {
    debugPrint("FileStorageService'dan nesne oluşturuldu.");
  }

  Future<String> getDirPath() async {
    var dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> getFile() async  {
    String dirPath = await getDirPath();
    File file = File("$dirPath/user.json");
    return file;
  }

  @override
  saveUser(UserModel user) async {
    File file = await getFile();
    await file.writeAsString(jsonEncode(user));
  }

  @override
  Future<UserModel> readUser() async {
    File file = await getFile();
    String jsonString = await file.readAsString();
    var json = jsonDecode(jsonString);
    return UserModel.fromJson(json);
  }
}
