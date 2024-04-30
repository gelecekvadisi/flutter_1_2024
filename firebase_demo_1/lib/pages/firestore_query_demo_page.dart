import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirestoreQueryDemoPage extends StatefulWidget {
  FirestoreQueryDemoPage({super.key});

  @override
  State<FirestoreQueryDemoPage> createState() => _FirestoreQueryDemoPageState();
}

class _FirestoreQueryDemoPageState extends State<FirestoreQueryDemoPage> {
  String displayText = "";
  var firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> displayData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firestore"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  firestore
                      .collection("user_detail")
                      .where("age", isGreaterThan: 25)
                      // .where("age", isLessThan: 25)
                      // .where("age", isNotEqualTo: 25)
                      .orderBy("city", descending: true)
                      .get()
                      .then((snapshot) {
                    setState(() {
                      displayData = snapshot.docs.map((e) => e.data()).toList();
                      displayText =
                          snapshot.docs.map((e) => e.data()).toString();
                    });
                  });
                },
                child: Text("25 Yaşında olmayanlar")),
            ListView.builder(
              shrinkWrap: true,
              itemCount: displayData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(displayData[index]["city"]?.toString() ??
                      "Şehir verisi yok"),
                  subtitle: Text(displayData[index]["age"]?.toString() ??
                      "Yaş verisi yok"),
                );
              },
            ),
            Text(displayText),
          ],
        ),
      ),
    );
  }

  _startAfterDocumentDemo() async {
    List<QueryDocumentSnapshot> docList = [];

    if (docList.isEmpty) {
      var snapshotPageOne = await firestore
        .collection("user_detail")
        .orderBy("ad", descending: false)
        .limit(20)
        .get();

        docList = snapshotPageOne.docs;
    } else {
      var snapshotPageTwo = await firestore
          .collection("user_detail")
          .orderBy("ad", descending: false)
          .startAfterDocument(docList.last)
          .limit(20)
          .get();

          docList = snapshotPageTwo.docs;
    }
  }
}
