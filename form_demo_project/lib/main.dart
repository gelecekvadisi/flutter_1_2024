import 'package:flutter/material.dart';
import 'package:form_demo_project/dropdown_button_page.dart';
import 'package:form_demo_project/form_field_page.dart';
import 'package:form_demo_project/home_page.dart';
import 'package:form_demo_project/selection_widget_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: DropdownButtonPage(),
    );
  }
}