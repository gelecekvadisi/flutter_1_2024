import 'package:flutter/material.dart';
import 'package:local_data_app/model/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPage extends StatefulWidget {
  DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  TextEditingController _nameController = TextEditingController();
  String renk = "Kırmızı";
  List<Sehir> sehirler = [];
  bool mezunMu = false;

  @override
  void initState() {
    super.initState();
    deneme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Sayfası"),
      ),
      body: ListView(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Ad Soyad",
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text("En sevidiğiniz renk hangisidir?"),
          _buildRadioButton("Kırmızı"),
          _buildRadioButton("Mavi"),
          _buildRadioButton("Yeşil"),
          _buildRadioButton("Sarı"),
          for (Sehir currentSehir in Sehir.values)
            _buildCheckboxButton(currentSehir),
          SwitchListTile(
            title: Text("Mezun oldunuz mu?"),
            value: mezunMu,
            onChanged: (value) {
              setState(() {
                mezunMu = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: saveUser,
            child: Text("Kaydet"),
          ),
        ],
      ),
    );
  }

  CheckboxListTile _buildCheckboxButton(Sehir sehir) {
    return CheckboxListTile(
        title: Text(sehir.name),
        value: sehirler.contains(sehir),
        onChanged: (value) {
          setState(() {
            if (value ?? false) {
              sehirler.add(sehir);
            } else {
              sehirler.remove(sehir);
            }
          });
        });
  }

  RadioListTile<String> _buildRadioButton(String renkAdi) {
    return RadioListTile(
      title: Text(renkAdi),
      value: renkAdi,
      groupValue: renk,
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          renk = value;
        });
      },
    );
  }

  saveUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String name = _nameController.text;
    preferences.setString("isim", name);
    preferences.setString("renk", renk);
    preferences.setStringList("sehirler", sehirler.map((e) => e.name).toList());
    preferences.setBool("mezunMu", mezunMu);
    debugPrint("Veriler Kaydedildi!");
  }
  
  void deneme() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("name", "Furkan");
    String? name = preferences.getString("name");
    debugPrint("Okunan name verisi: $name");
  }
}
