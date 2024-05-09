import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scapp_firestore/firebase_options.dart';
import 'package:scapp_firestore/routes/routes.dart';
import 'package:scapp_firestore/theme/dark.dart';
import 'package:scapp_firestore/theme/light.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: light,
      darkTheme: dark,
      routes: routes,
    );
  }
}
