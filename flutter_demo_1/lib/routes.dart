import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_1/navigator_demos/green_page.dart';
import 'package:flutter_demo_1/navigator_demos/home_page.dart';
import 'package:flutter_demo_1/navigator_demos/red_page.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routeMap = {
    "/": (context) => const HomePage(),
    "/red_page": (context) => RedPage(price: 0),
    "/green_page": (context) => GreenPage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Widget page = const Scaffold(
      backgroundColor: Colors.blue,
    );

    int yetkiId = 0;

    

    if (settings.name == "/" || settings.name == "/homePage") {
      page = const HomePage();
    } else if (settings.name == "/redPage") {
      double price = double.tryParse("Furkan 100 Tl ödedi.") ?? 0;
      
      //double price = settings.arguments as double;  //  type casting

      page = RedPage(price: price);
    } else if (settings.name == "/greenPage" && yetkiId == 1) {
      page = GreenPage();
    } else if (settings.name == "/bluePage") {
      page = const Scaffold();
    }

    if (Platform.isIOS) {
      return CupertinoPageRoute(builder: (context) => page, settings: settings);
    } else {
      return MaterialPageRoute(builder: (context) => page, settings: settings);
    }
  }
}
