import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo_1/firebase_options.dart';
import 'package:firebase_demo_1/pages/firestore_page.dart';
import 'package:firebase_demo_1/pages/firestore_query_demo_page.dart';
import 'package:firebase_demo_1/pages/login_page.dart';
import 'package:firebase_demo_1/pages/manage_user_page.dart';
import 'package:firebase_demo_1/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: RegisterPage(),
    );
  }
}