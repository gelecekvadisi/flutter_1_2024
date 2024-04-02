import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_data_app/service/locale_storage_service.dart';

import '../model/enums.dart';
import '../model/user_model.dart';

class SecureStorageService extends LocaleStorageService{
  // FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  saveUser(UserModel user) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    storage.write(key: "name", value: user.name);
    storage.write(key: "renk", value: user.renk);

    var stringList = user.sehirler.map((e) => e.name).toList();
    storage.write(key: "sehirler", value: jsonEncode(stringList));
    storage.write(key: "mezunMu", value: user.mezunMu.toString());
  }

  @override
  Future<UserModel> readUser() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    String name = (await storage.read(key: "name")) ?? "";
    String renk = (await storage.read(key: "renk")) ?? "";
    List? sehirlerStringList = jsonDecode(
      await storage.read(key: "sehirler") ?? "[]",
    );
    if (sehirlerStringList == null) {
      sehirlerStringList = [];
    }
    List<Sehir> sehirler = sehirlerStringList
        .map(
          (sehirString) => Sehir.values.firstWhere(
            (sehir) => sehir.name == sehirString.toString(),
          ),
        )
        .toList();

    bool mezunMu = (await storage.read(key: "mezunMu")) == "true";

    UserModel user = UserModel(
      name: name,
      renk: renk,
      sehirler: sehirler,
      mezunMu: mezunMu,
    );

    return user;
  }
}
