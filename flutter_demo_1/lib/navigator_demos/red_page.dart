import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo_1/odev10/person.dart';

class RedPage extends StatelessWidget {
  RedPage({super.key});

  double price = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        showDialog(
            context: context,
            builder: (dcontext) {
              return AlertDialog(
                title: Text("Sayfadan çıkmak istediğinize emin misiniz?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text("Sayfadan çık")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("İptal")),
                ],
              );
            });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text("RedPage"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () {
                    price = 100 + (Random().nextDouble() * 100);

                    /// 100 <= price < 200
                    print("Ücret: $price");
                    bool canPop = Navigator.canPop(context);
                    Navigator.maybePop(
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
      ),
    );
  }
}
