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
  bool? kvkkOnayi = false;
  bool? yemek1 = false;
  bool? yemek2 = false;
  bool? yemek3 = false;

  bool erkekMi = true;
  Cinsiyet cinsiyet = Cinsiyet.erkek;

  bool switchValue = false;

  double yas = 1;
  String yasMetni = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selection Widgets"),
      ),
      body: Column(
        children: [
          ...checkBoxWidgetList(),
          ...radioWidgetList(),
          ...switchWidgetList(),
          ...sliderWidgetList(),
        ],
      ),
    );
  }

  List<Widget> checkBoxWidgetList() {
    return [
      CheckboxListTile(
        title: Text("Yemek 1"),
        subtitle: Text("A Firması"),
        // activeColor: Colors.red,
        // checkColor: Colors.black,
        secondary: Icon(Icons.check),
        value: yemek1,
        enabled: true,
        onChanged: (value) {
          setState(() {
            //  kvkkOnayi = value ?? false;
            yemek1 = value;
          });
        },
      ),
      CheckboxListTile(
        title: Text("Yemek 2"),
        subtitle: Text("A Firması"),
        // activeColor: Colors.red,
        // checkColor: Colors.black,
        secondary: Icon(Icons.check),
        value: yemek2,
        enabled: true,
        onChanged: (value) {
          setState(() {
            //  kvkkOnayi = value ?? false;
            yemek2 = value;
          });
        },
      ),
      CheckboxListTile(
        title: Text("Yemek 3"),
        subtitle: Text("A Firması"),
        // activeColor: Colors.red,
        // checkColor: Colors.black,
        secondary: Icon(Icons.check),
        value: yemek3,
        enabled: true,
        onChanged: (value) {
          setState(() {
            //  kvkkOnayi = value ?? false;
            yemek3 = value;
          });
        },
      ),
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
    ];
  }

  List<Widget> radioWidgetList() {
    return [
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
    ];
  }

  List<Widget> switchWidgetList() {
    return [
      Switch.adaptive(
          value: switchValue,
          onChanged: (bool value) {
            setState(() {
              switchValue = value;
            });
          }),
      SwitchListTile(
          title: Text("Zili çalma. Telefonla ara."),
          subtitle: Text("Siparişiniz kapıya geldiğinde aranacaksınız."),
          thumbIcon: MaterialStateProperty.resolveWith<Icon>((states) {
            if (states.contains(MaterialState.selected)) {
              return Icon(Icons.check);
            } else {
              return Icon(Icons.close);
            }
          }),
          value: switchValue,
          onChanged: (bool value) {
            setState(() {
              switchValue = value;
            });
          }),
    ];
  }

  List<Widget> sliderWidgetList() {
    return [
      Slider(
        min: 1,
        max: 100,
        divisions: 99,
        label: yas.round().toString(),
        value: yas,
        onChanged: (value) {
          setState(() {
            yas = value;
            if (yas < 18) {
              yasMetni = "Yaşınız 18'den küçük.";
            } else {
              yasMetni = yas.round().toString();
            }
          });
        },
      ),
      Text(yasMetni),
      ElevatedButton(
          onPressed: () {
            if (yas < 18) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Yaşınız 18'den küçük. Uygulamaya giriş yapamazsınız!"),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Uygulamaya giriş yaptınız."),
                ),
              );
            }
          },
          child: Text("Kaydet"))
    ];
  }
}
