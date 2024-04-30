import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Product {
  String name;
  String color;
  double price;

  Product({
    required this.name,
    required this.color,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json["name"],
      color: json["color"],
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "color": color,
      "price": price,
    };
  }
}

class FirestoreConverterDemoPage extends StatefulWidget {
  FirestoreConverterDemoPage({super.key});

  @override
  State<FirestoreConverterDemoPage> createState() =>
      _FirestoreConverterDemoPageState();
}

class _FirestoreConverterDemoPageState
    extends State<FirestoreConverterDemoPage> {
  var firestore = FirebaseFirestore.instance;
  late CollectionReference<Product> collectionRef;

  @override
  void initState() {
    super.initState();
    collectionRef = firestore.collection("product").withConverter<Product>(
      fromFirestore: (snapshot, options) {
        return Product.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore Converter"),
      ),
      body: Container(),
    );
  }

  _addData() {
    /* firestore.collection("product").add(
          Product(name: "Bilgisayar", color: "Siyah", price: 20000).toJson(),
        ); */
        collectionRef.add(Product(name: "Bilgisayar", color: "Siyah", price: 20000));
  }

  _demoConverter() async {
    var querySnapshot = await collectionRef.get();
    Product product = querySnapshot.docs[0].data();
  }
}
