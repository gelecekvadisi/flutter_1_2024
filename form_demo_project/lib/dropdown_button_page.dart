import 'package:flutter/material.dart';

class DropdownButtonPage extends StatefulWidget {
  const DropdownButtonPage({super.key});

  @override
  State<DropdownButtonPage> createState() => _DropdownButtonPageState();
}

class _DropdownButtonPageState extends State<DropdownButtonPage> {
  int? secilenSehir;
  List<String> sehirler = [
    "İstanbul",
    "Ankara",
    "Bursa",
    "İzmir",
    "Adıyaman",
    "Malatya",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown Button Page"),
      ),
      body: Center(
        child: DropdownButton<int>(
          /* items: const [
            DropdownMenuItem<int>(child: Text("İstanbul"), value: 34,),
            DropdownMenuItem<int>(child: Text("Ankara"), value: 6,),
            DropdownMenuItem<int>(child: Text("Bursa"), value: 16,),
            DropdownMenuItem<int>(child: Text("İstanbul"), value: 35,),
            DropdownMenuItem<int>(child: Text("Ankara"), value: 7,),
            DropdownMenuItem<int>(child: Text("Bursa"), value: 17,),
          ], */
          /* items: sehirler
              .map(
                (e) => DropdownMenuItem<int>(
                  child: Text(e),
                  value: sehirler.indexOf(e),
                ),
              )
              .toList(), */
          items: menuItemList(),
          value: secilenSehir,
          hint: Text("Şehir seçiniz..."),
          isExpanded: false,
          menuMaxHeight: 200,
          onChanged: (value) {
            setState(() {
              secilenSehir = value;
            });
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> menuItemList() {
    List<DropdownMenuItem<int>> itemList = [];

    for (int i = 0; i < sehirler.length; i++) {
      itemList.add(
        DropdownMenuItem<int>(
          child: Text(sehirler[i]),
          value: i,
        ),
      );
    }
    return itemList;
  }
}
