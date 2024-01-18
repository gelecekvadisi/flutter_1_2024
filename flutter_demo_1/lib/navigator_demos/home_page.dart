import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_1/odev10/person.dart';

import 'red_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Ana Sayfa"),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white),
              onPressed: () async {
                Person? person = await Navigator.of(context).push<Person>(
                    MaterialPageRoute(builder: (context) => RedPage()));
                debugPrint(
                    "Ana sayfada kişi adı: ${person?.name ?? "Kişi bulunamadı"}");
              },
              child: Text("Navigate to RedPage with Material"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white),
              onPressed: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (context) => RedPage()));
              },
              child: Text("Navigate to RedPage with Cupertino"),
            ),
          ],
        ),
      ),
    );
  }
}
