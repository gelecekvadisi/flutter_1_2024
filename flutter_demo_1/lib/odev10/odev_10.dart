import 'package:flutter/material.dart';

import 'person.dart';

class Odev10 extends StatelessWidget {
  Odev10({super.key});

  List<Person> personList = [
    Person(
        name: "Joe Belfiore",
        description: "in a world far away",
        imageUrl: "https://picsum.photos/200"),
    Person(
        name: "Bill Gates",
        description: "What l'm doing here?",
        imageUrl: "https://picsum.photos/200"),
    Person(
        name: "Joe Belfiore",
        description: "in a world far away",
        imageUrl: "https://picsum.photos/200"),
    Person(
        name: "Bill Gates",
        description: "What l'm doing here?",
        imageUrl: "https://picsum.photos/200"),
    Person(
        name: "Joe Belfiore",
        description: "in a world far away",
        imageUrl: "https://picsum.photos/200"),
    Person(
        name: "Bill Gates",
        description: "What l'm doing here?",
        imageUrl: "https://picsum.photos/200"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
        shape: CircleBorder(),
        backgroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          Person person = personList[index];

          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage(person.imageUrl),
              ),
              title: Text(person.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(person.description),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Container(height: 8);
        },
        itemCount: personList.length,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Contacts"),
      centerTitle: true,
      leading: Icon(Icons.menu),
      actions: [Icon(Icons.search)],
      backgroundColor: Colors.white,
      shadowColor: Colors.black45,
      elevation: 16,
    );
  }
}
