import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_1/custom_scroll_view_page.dart';
import 'package:flutter_demo_1/grid_view_page.dart';
import 'package:flutter_demo_1/routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'navigator_demos/home_page.dart';
import 'navigator_demos/red_page.dart';
import 'odev10/person.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Person ahmet = Person(
        name: "Ahmet",
        description: "What l'm doing here?",
        imageUrl: "https://picsum.photos/200");
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.black54.withOpacity(0.5)
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
      ..toastPosition = EasyLoadingToastPosition.bottom;

    /* if (Platform.isIOS) {
      return CupertinoApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        home: HomePage(),
      );
    } */

    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      routes: Routes.routeMap,
      onUnknownRoute: (context) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text("Sayfa bulunamadı!"),
          ),
        ),
      ),
      // home: HomePage(),
    );
  }
}
