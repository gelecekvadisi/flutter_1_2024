import 'package:flutter/material.dart';
import 'package:flutter_widgets_1/pages/home_page.dart';
import 'package:flutter_widgets_1/pages/page_view.dart';
import 'package:flutter_widgets_1/pages/tab_bar_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: TabBarPage(),
    );
  }
}