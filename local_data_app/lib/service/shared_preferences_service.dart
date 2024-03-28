import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/enums.dart';
import '../model/user_model.dart';

class SharedPreferencesService {
  saveUser(UserModel user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("isim", user.name);
    preferences.setString("renk", user.renk);
    preferences.setStringList(
        "sehirler", user.sehirler.map((e) => e.name).toList());
    preferences.setBool("mezunMu", user.mezunMu);
    debugPrint("Veriler Kaydedildi!");
  }

  Future<UserModel> readUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String name = preferences.getString("isim") ?? "";
    String renk = preferences.getString("renk") ?? "";

    List<Sehir> sehirler = [];
    List? sehirStringList = preferences.getStringList("sehirler");
    if (sehirStringList != null) {
      sehirler = sehirStringList
          .map(
            (sehirString) => Sehir.values.firstWhere(
              (sehir) => sehir.name == sehirString,
            ),
          )
          .toList();
    }

    bool mezunMu = preferences.getBool("mezunMu") ?? false;

    UserModel user = UserModel(name: name, renk: renk, sehirler: sehirler, mezunMu: mezunMu);
    return user;
  }
}
