import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scapp_firestore/utils/color_schema.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Kullanici>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = _kullaniciAra('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Kullanici>> _kullaniciAra(String aramaMetni) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: aramaMetni)
        .get();

    List<Kullanici> kullanicilar = snapshot.docs.map((doc) {
      return Kullanici.fromDocument(doc);
    }).toList();

    return kullanicilar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              controller: _searchController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: context.colorScheme.primary,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: context.colorScheme.error,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: context.colorScheme.primary,
                  ),
                ),
                labelText: 'User Name',
                labelStyle: TextStyle(
                  color: context.colorScheme.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchResults = _kullaniciAra(value);
                });
              },
            ),
            Expanded(
              child: FutureBuilder<List<Kullanici>>(
                future: _searchResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text(
                      'No results found',
                      style: TextStyle(color: context.colorScheme.primary),
                    ));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Kullanici kullanici = snapshot.data![index];
                      return ListTile(
                        title: Text(kullanici.kullaniciAdi),
                        subtitle: Text(kullanici.eposta,
                            style:
                                TextStyle(color: context.colorScheme.primary)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Kullanici {
  final String kullaniciAdi;
  final String eposta;

  Kullanici({required this.kullaniciAdi, required this.eposta});

  factory Kullanici.fromDocument(DocumentSnapshot doc) {
    return Kullanici(
      kullaniciAdi: doc['username'],
      eposta: doc['email'],
    );
  }
}
