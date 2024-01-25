import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo_1/odev10/person.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'green_page.dart';

class RedPage extends StatelessWidget {
  RedPage({super.key, required this.price});

  double price = 0;

  @override
  Widget build(BuildContext context) {

    /* var arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) {
      EasyLoading.showToast("Sayfa argümanlarıı: $arguments");
    } */

    EasyLoading.showToast("Ödenecek tutar: $price");
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
          automaticallyImplyLeading: true,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildGreenPageButton(context),
              ElevatedButton(
                  onPressed: () {
                    price = 100 + (Random().nextDouble() * 100);

                    /// 100 <= price < 200-
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

  ElevatedButton _buildGreenPageButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent, foregroundColor: Colors.white),
      onPressed: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => GreenPage(),
          ),
          (route) => false,
        );
      },
      child: Text("Navigate to GreenPage with Material"),
    );
  }
}
