import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scapp_firestore/page/home/on_home_page.dart';
import 'package:scapp_firestore/page/security/onboard/onboard.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeViewScreen(selectedIndex: 0,);
          } else {
            return const OnBoardPage();
          }
        },
      ),
    );
  }
}
