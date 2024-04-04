import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_data_app/model/enums.dart';
import 'package:local_data_app/model/user_model.dart';

class HiveDemoPage extends StatelessWidget {
  const HiveDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    dataProcess();
    // userProcess();
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Storage Demo"),
      ),
      body: Container(),
    );
  }

  userProcess() async {
    Box userBox = Hive.box<UserModel>("users");
    await userBox.clear();
    await userBox.put(0, UserModel(
      name: "Furkan Yağmur",
      renk: "Kırmızı",
      sehirler: [
        Sehir.Ankara,
        Sehir.Bursa
      ],
      mezunMu: true,
    ));
    debugPrint(userBox.toMap().toString());
  }

  dataProcess() async {
    Box box = Hive.box("test");

    await box.clear();
    box.add("Furkan");
    box.add(2024);
    box.add("İstanbul");
    box.put("yas", 25);
    debugPrint(box.get(2).toString());

    debugPrint(box.toMap().toString());

    debugPrint("-----------------------");
    for (dynamic key in box.keys) {
      debugPrint("$key: ${box.get(key)}");
    }
    debugPrint("-----------------------");

    box.addAll([
      "Ahmet",
      "Mehmet",
      "Ali",
    ]);

    box.putAll({
      "bolum": "Bilgisayar Müh.",
      "universite": "Dumlupınar Üni.",
      "sinifi": 4,
      "gno": 3.14,
    });

    debugPrint(box.getAt(6).toString());

    await box.delete(2);
    await box.deleteAll(["gno", 3, 5, "sinifi"]);
    debugPrint(box.keyAt(4).toString());

    debugPrint("${box.length} tane veri var.");

    await box.putAt(4, "YTÜ");
    await box.compact();
    await box.add("Yeni eklenen veri");

    debugPrint(box.toMap().toString());
  }
}
