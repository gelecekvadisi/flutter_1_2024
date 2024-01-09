import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'kisi.dart';

class ListViewPage extends StatelessWidget {
  ListViewPage({super.key});

  List<Kisi> kisiListesi = List.generate(5000, (index) {
    String yeniIndex = (index + 1).toString();
    return Kisi(yeniIndex, "Kisi $yeniIndex adı", "Kisi $yeniIndex soyadı");
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View Demo"),
      ),
      body: ListView.separated(
        itemCount: kisiListesi.length,
        // reverse: true,
        itemBuilder: (context, index) {
          Kisi kisi = kisiListesi[index];
          return _buildPersonCard(index, kisi);
        },
        separatorBuilder: (context, index) {
          if ((index+1)%14 == 0) {
            return _buildSeperetor();
          } else {
            return SizedBox();
          }
          
        },
      ),
    );
  }

  Container _buildSeperetor() {
    return Container(
            height: 300,
            color: Colors.red,
          );
  }

  Card _buildPersonCard(int index, Kisi kisi) {
    return Card(
          color: index % 2 == 0 ? Colors.white : Colors.grey,
          child: ListTile(
            title: Text(kisi.name),
            subtitle: Text(kisi.surName),
            leading: CircleAvatar(
              child: Text(kisi.id),
            ),
            onTap: (){
              if (index %2 ==0) {
                EasyLoading.instance.backgroundColor = Colors.red;
              } else {
                EasyLoading.instance.backgroundColor = Colors.black;
              }
              EasyLoading.showToast(kisi.name);
            },
          ),
        );
  }

  ListView listViewWithBuilder() {
    return ListView.builder(
      itemBuilder: (context, index) {
        Kisi kisi = kisiListesi[index];
        return Card(
          color: index % 2 == 0 ? Colors.white : Colors.grey,
          child: ListTile(
            title: Text(kisi.name),
            subtitle: Text(kisi.surName),
            leading: CircleAvatar(
              child: Text(kisi.id),
            ),
          ),
        );
      },
      itemCount: kisiListesi.length,
      reverse: true,
    );
  }

  Widget rehberListView() {
    /* return SingleChildScrollView(
      child: Column(
        children: kisiListesi
          .map((kisi) =>
              buildCard(name: kisi.name, lastName: kisi.surName, id: kisi.id))
          .toList(),
      ),
    ); */

    return ListView(
      children: kisiListesi
          .map((kisi) =>
              buildCard(name: kisi.name, lastName: kisi.surName, id: kisi.id))
          .toList(),
    );
  }

  /* ListView listView() {
    return ListView(
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
      ],
    );
  } */

  Widget buildCard(
      {required String id, required String name, required String lastName}) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                id,
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(name),
            subtitle: Text(lastName),
            trailing: Icon(Icons.call),
          ),
        ),
        Divider(),
      ],
    );
  }
}
