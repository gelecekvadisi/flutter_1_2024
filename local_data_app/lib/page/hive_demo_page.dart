import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDemoPage extends StatelessWidget {
  const HiveDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    dataProcess();
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Storage Demo"),
      ),
      body: Container(),
    );
  }

  dataProcess() async {
    Box box = Hive.box("test");
    await box.clear();
    await box.add("Furkan");
    await box.add("Yağmur");
    await box.add("İstanbul");
    await box.add(2024);
    await box.add(true);

    await box.put("ad_soyad", "Furkan Yağmur");

    debugPrint(box.toMap().toString());
  }
}
