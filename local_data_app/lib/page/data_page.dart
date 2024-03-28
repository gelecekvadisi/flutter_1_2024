import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:local_data_app/model/enums.dart';
import 'package:local_data_app/model/user_model.dart';
import 'package:local_data_app/service/secure_storage_service.dart';
import 'package:local_data_app/service/shared_preferences_service.dart';
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
  SecureStorageService service = SecureStorageService();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      // mezunMu = true;
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("content")));
      // setState(() {});
      
      var user = await service.readUser();
      _nameController.text = user.name;
      renk = user.renk;
      sehirler = user.sehirler;
      mezunMu = user.mezunMu;
      setState(() {});

    });
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
            onPressed: () {
              service.saveUser(
                UserModel(
                  name: _nameController.text,
                  renk: renk,
                  sehirler: sehirler,
                  mezunMu: mezunMu,
                ),
              );
            },
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

  void deneme() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("name", "Furkan");
    String? name = preferences.getString("name");
    debugPrint("Okunan name verisi: $name");
  }
}
