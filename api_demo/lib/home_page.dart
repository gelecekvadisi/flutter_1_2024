import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/ogrenci.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Json Deneme"),
      ),
      body: FutureBuilder<List<Ogrenci>>(
        future: verilerOku(context),
        builder: (context, snapshot) {
          // if(snapshot.connectionState == ConnectionState.done)
          if (snapshot.hasData) {
            List<Ogrenci> ogrenciListesi = snapshot.data!;

            return ListView.builder(
                itemCount: ogrenciListesi.length,
                itemBuilder: (contex, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        ogrenciListesi[index].gno?.toString() ?? "0.00",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                        ogrenciListesi[index].adSoyad ?? "Ad Soyad Bulunamadı"),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),);
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

  Future<List<Ogrenci>> verilerOku(BuildContext context) async {
    try {
      await Future.delayed(Duration(seconds: 5));
      
      // throw Exception("Bir hata meydana geldi!");

      List<Ogrenci> ogrenciListesi = [];

      String jsonString =
          await DefaultAssetBundle.of(context).loadString("assets/obs.json");

      ogrenciListesi = (jsonDecode(jsonString) as List)
          .map((e) => Ogrenci.fromJson(e as Map<String, dynamic>))
          .toList();

      debugPrint(ogrenciListesi.toString());
      return ogrenciListesi;
    } catch (e) {
      debugPrint("HATA: ");
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
}
