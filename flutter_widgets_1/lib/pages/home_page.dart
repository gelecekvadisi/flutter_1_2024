import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Hello World', style: TextStyle(
                fontFamily: "NotoSerif",
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal
              ),),
              Text('Hello World', style: GoogleFonts.limelight(),),
            ],
          ),
        ),
      );
  }
}