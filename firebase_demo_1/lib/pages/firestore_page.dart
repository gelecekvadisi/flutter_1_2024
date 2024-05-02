import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirestorePage extends StatelessWidget {
  FirestorePage({super.key});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Firestore"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _addData();
                await _querySnapshotDemo();
              },
              child: const Text("Veri Ekle"),
            ),
            ElevatedButton(
              onPressed: () {
                _incrementCounter();
              },
              child: const Text("Sayacı 1 artır"),
            ),
            ElevatedButton(
              onPressed: () {
                _readData();
              },
              child: const Text("Veri Oku"),
            ),
            ElevatedButton(
                onPressed: () {
                  _transactionDemo();
                },
                child: const Text("Transaction")),
            const Divider(),
            _buildOneTimeDataText(),
          ],
        ),
      ),
    );
  }

  StreamBuilder<dynamic> _buildRealtimeDataText() {
    Stream userDetailStream = firestore
        .collection("user_detail")
        .doc("joDZuu0lMf31h49MD49J")
        .snapshots();
    return StreamBuilder(
        stream: userDetailStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Bir hata meydana geldi!");
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Text("Dökümanda veri yok!");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          var docSnapshot = snapshot.data!;
          return Text(docSnapshot.data().toString());
        });
  }

  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>
      _buildOneTimeDataText() {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _readData(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Bir hata meydana geldi!");
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Text("Dökümanda veri yok!");
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          var docSnapshot = snapshot.data!;
          return Text(docSnapshot.data().toString());
        }

        return const CircularProgressIndicator();
      }),
    );
  }

  _addData() async {
    debugPrint("Veri ekle tıklandı!");
    CollectionReference collectionRef = firestore.collection("user_detail");
    DocumentReference docRef = await collectionRef.add({
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

    /////////////////////////////////////////////////////////

    DocumentReference documentReference = collectionRef.doc("654323456");
    // (await documentReference.get()).exists;
    await documentReference.set({
      "ad": "Furkan",
      "soyad": "Yağmur",
    });
    debugPrint("Yeni döküman eklendi: ${documentReference.path}");
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _readData() async {
    return firestore
        .collection("user_detail")
        .doc("joDZuu0lMf31h49MD49J")
        .get();
  }

  _querySnapshotDemo() async {
    QuerySnapshot querySnapshot =
        await firestore.collection("user_detail").get();
    List<DocumentChange> changeList = querySnapshot.docChanges;
    debugPrint(
        "Değişen döküman bilgileri:" + changeList[0].doc.data().toString());
  }

  void _incrementCounter() async {
    debugPrint("Sayaç artırılacak.");

    DocumentReference docRef = firestore.collection("config").doc("counter");
    if (!(await docRef.get()).exists) {
      await docRef.set({"counter": 0});
    }

    await firestore.collection("config").doc("counter").update({
      "tıklama_sayısı": FieldValue.increment(1),
    });
    debugPrint("Sayaç artırıldı.");
  }

  _transactionDemo() {
    var firestore = FirebaseFirestore.instance;
    var collectionRef = firestore.collection("user");
    
    var furkanDocRef = collectionRef.doc("0Gp3UC8rtVfObc89nPFUp6EWHXf2");
    var osmanDocRef = collectionRef.doc("JCDZdAlqa9Y667WhCTWlovvWjDj2");

    firestore.runTransaction((transaction) async {
      var furkan = await transaction.get(furkanDocRef);

      transaction.update(furkanDocRef, {"bakiye": FieldValue.increment(-100)});

      if (furkan.data()!["bakiye"] < 100) {
        debugPrint("Furkanın bakiyesi yetersiz.");
        throw Exception("Furkanın bakiyesi yetersiz.");
      }

      transaction.update(osmanDocRef, {"bakiye": FieldValue.increment(100)});
    }).then((value) {
      debugPrint("Güncelleme işlemi başarılı");
    }).catchError((Exception e) {
      debugPrint(e.toString());
    });
  }
}
