import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_data_app/model/enums.dart';
import 'package:local_data_app/model/user_model.dart';
import 'package:local_data_app/page/data_page.dart';
import 'package:local_data_app/page/hive_demo_page.dart';
import 'package:local_data_app/service/file_storage_service.dart';
import 'package:local_data_app/service/locale_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locator.dart';
import 'service/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Hive.initFlutter();
  Hive.registerAdapter(SehirAdapter());
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox("test");
  await Hive.openBox<UserModel>("users");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Builder(builder: (BuildContext builderContext) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Lokal Veri Uygulamaları'),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(builderContext).push(
                        MaterialPageRoute(
                          builder: (context) => DataPage(),
                        ),
                      );
                    },
                    child: Text("Navigate to data page")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(builderContext).push(
                        MaterialPageRoute(
                          builder: (context) => HiveDemoPage(),
                        ),
                      );
                    },
                    child: Text("Navigate to Hive Demo Page")),
              ],
            ),
          ),
        );
      }),
    );
  }
}
