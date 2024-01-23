import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo_1/odev10/person.dart';

class GreenPage extends StatelessWidget {
  GreenPage({super.key});

  double price = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("RedPage"),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  price = 100 + (Random().nextDouble() * 100);
    
                  /// 100 <= price < 200-
                  print("Ücret: $price");
                  bool canPop = Navigator.canPop(context);
                  Navigator.pop(
                      context,
                      Person(
                          name: "Furkan",
                          description: "Açıklama",
                          imageUrl: "imageUrl"));
                },
                child: Text("Go back")),
          ],
        ),
      ),
    );
  }
}
