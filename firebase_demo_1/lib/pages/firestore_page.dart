import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirestorePage extends StatelessWidget {
  FirestorePage({super.key});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Stream userDetailStream = firestore
        .collection("user_detail")
        .doc("joDZuu0lMf31h49MD49J")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firestore"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _addData();
              },
              child: Text("Veri Ekle"),
            ),
            ElevatedButton(
              onPressed: () {
                _readData();
              },
              child: Text("Veri Oku"),
            ),
            Divider(),
            StreamBuilder(
                stream: userDetailStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Bir hata meydana geldi!");
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return Text("Dökümanda veri yok!");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  
                    var docSnapshot = snapshot.data!;
                    return Text(docSnapshot.data().toString());
                  

                  
                })
          ],
        ),
      ),
    );
  }

  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>
      _buildOneTimeDataText() {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _readData(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Text("Bir hata meydana geldi!");
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Text("Dökümanda veri yok!");
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          var docSnapshot = snapshot.data!;
          return Text(docSnapshot.data().toString());
        }

        return CircularProgressIndicator();
      }),
    );
  }

  _addData() async {
    DocumentReference<Map<String, dynamic>> docRef =
        await firestore.collection("user_detail").add({
      "photo":
          "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg",
      "city": "Ankara",
      "age": 25,
      "isMale": true,
      "permissions": [
        "read",
        "write",
        "delete",
      ],
      "date_of_registration": Timestamp.now()
    });
    debugPrint("Kullanıcı detay verisi kaydedildi!");
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _readData() async {
    return firestore
        .collection("user_detail")
        .doc("joDZuu0lMf31h49MD49J")
        .get();
  }
}
