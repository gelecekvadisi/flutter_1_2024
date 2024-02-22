import 'package:flutter/material.dart';
import 'package:form_demo_project/dialog_page.dart';
import 'package:form_demo_project/dropdown_button_page.dart';
import 'package:form_demo_project/form_field_page.dart';
import 'package:form_demo_project/home_page.dart';
import 'package:form_demo_project/selection_widget_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_demo_project/stepper_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      /* localizationsDelegates: [
         GlobalMaterialLocalizations.delegate
       ],
      supportedLocales: [
        Locale("en", "US"),
        Locale("tr", "TR"),
      ],
      locale: Locale("tr", "TR"), */
      title: 'Material App',
      home: StepperPage(),
    );
  }
}