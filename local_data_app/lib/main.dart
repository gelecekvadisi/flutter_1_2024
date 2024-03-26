import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_data_app/page/data_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

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
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(builderContext).push(
                    MaterialPageRoute(
                      builder: (context) => DataPage(),
                    ),
                  );
                },
                child: Text("Navigate to data page")),
          ),
        );
      }),
    );
  }
}
