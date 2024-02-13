import 'package:flutter/material.dart';

enum Cinsiyet {
  erkek,
  kadin,
}

/* enum Tables {
  user,
  payment,
  address,
  profile,
  invoice,
} */

class SelectionWidgetPage extends StatefulWidget {
  const SelectionWidgetPage({super.key});

  @override
  State<SelectionWidgetPage> createState() => _SelectionWidgetPageState();
}

class _SelectionWidgetPageState extends State<SelectionWidgetPage> {
  bool? kvkkOnayi = true;

  bool erkekMi = true;
  Cinsiyet cinsiyet = Cinsiyet.erkek;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selection Widgets"),
      ),
      body: Column(
        children: [
          CheckboxListTile(
            title: Text("KVKK Onayı"),
            subtitle: Text("KVKK metnimizi okuduysanız bu alanı işaretleyin."),
            // activeColor: Colors.red,
            // checkColor: Colors.black,
            secondary: Icon(Icons.check),
            tristate: true,
            value: kvkkOnayi,
            enabled: true,
            onChanged: (value) {
              setState(() {
                //  kvkkOnayi = value ?? false;
                kvkkOnayi = value;
              });
            },
          ),
          RadioListTile<Cinsiyet>(
            title: Text("Erkek"),
            groupValue: cinsiyet,
            value: Cinsiyet.erkek,
            onChanged: (value) {
              setState(() {
                cinsiyet = value!;
              });
              
            },
          ),
          RadioListTile<Cinsiyet>(
            title: Text("Kadın"),
            groupValue: cinsiyet,
            value: Cinsiyet.kadin,
            onChanged: (value) {
              setState(() {
                cinsiyet = value!;
              });
              
            },
          ),
        ],
      ),
    );
  }
}
