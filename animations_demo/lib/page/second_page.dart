import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Hero(
          tag: "flutter_logo",
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
