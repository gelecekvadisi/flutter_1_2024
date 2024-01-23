import 'package:flutter/material.dart';
import 'package:flutter_demo_1/navigator_demos/green_page.dart';
import 'package:flutter_demo_1/navigator_demos/home_page.dart';
import 'package:flutter_demo_1/navigator_demos/red_page.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routeMap = {
    "/": (context) => HomePage(),
    "/red_page": (context) => RedPage(),
    "/green_page": (context) => GreenPage(),
  };
}