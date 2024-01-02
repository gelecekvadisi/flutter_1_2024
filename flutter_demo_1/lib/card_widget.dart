import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  CardWidget({super.key});

  List<String> kisiler = ["Ahmet", "Mehmet", "Ali", "Veli"];

  @override
  Widget build(BuildContext context) {
    kisiler.sort((first, second) {
      return first.compareTo(second);
    });

    debugPrint(kisiler.toString());

    return Scaffold(
      appBar: AppBar(title: Text("Card kullanımı")),
      body: Center(
        child: SingleChildScrollView(
          // reverse: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              buildCard("Furkan", "Yağmur"),
              buildCard("Vural", "Bozkurt"),
              buildCard("Erhan", "Gökçeoğlu"),
              buildCard("Furkan", "Yağmur"),
              buildCard("Furkan", "Yağmur"),
              buildCard("Furkan", "Yağmur"),
              buildCard("Furkan", "Yağmur"),
              buildCard("Furkan", "Yağmur"),
              buildCard("Furkan", "Yağmur"),
              buildCard("Furkan", "Yağmur"),
              buildCard("Furkan", "Yağmur"),
              buildCard("Furkan", "Yağmur"),
              Text("${kisiler.length} kişi bulundu"),
              ElevatedButton(onPressed: () {}, child: Text("Yeni Kişi Ekle")),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String name, String lastName) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                "1",
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(name),
            subtitle: Text(lastName),
            trailing: Icon(Icons.delete),
          ),
        ),
        Divider(),
      ],
    );
  }

  Center firstCard() {
    return Center(
      child: Card(
        color: Colors.blue,
        shadowColor: Colors.yellow,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Text(
          "Flutter",
          style: TextStyle(fontSize: 64),
        ),
      ),
    );
  }
}
