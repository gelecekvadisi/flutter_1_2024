import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'kisi.dart';

class ListViewPage extends StatelessWidget {
  ListViewPage({super.key});

  List<Kisi> kisiListesi = List.generate(5000, (index) {
    String yeniIndex = (index + 1).toString();
    return Kisi(yeniIndex, "Kisi $yeniIndex adı", "Kisi $yeniIndex soyadı");
  });

  String text =
      """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin aliquam fringilla nisl, eu fermentum ante pellentesque eu. Mauris rhoncus lectus ut dictum pretium. Nullam ullamcorper consectetur risus. Donec odio orci, volutpat pellentesque blandit vitae, condimentum nec augue. Donec porttitor vitae nunc quis gravida. Nullam mollis justo risus, a facilisis velit tincidunt vel. Proin eget velit laoreet, molestie tellus id, tincidunt massa. Vestibulum facilisis sem massa, placerat accumsan urna gravida non.

Fusce quis leo feugiat, molestie arcu sit amet, congue quam. Integer nisl orci, fermentum in vulputate id, convallis sit amet purus. Suspendisse non fermentum quam, efficitur tincidunt ex. Vestibulum congue, dolor id luctus tincidunt, dui urna tempus odio, vulputate posuere tellus magna quis diam. Sed sagittis sagittis lorem, ut posuere odio faucibus at. Suspendisse at turpis eget purus convallis tincidunt nec vitae diam. Pellentesque accumsan sollicitudin cursus. Pellentesque a enim molestie, vulputate nibh sit amet, scelerisque leo. Praesent varius, diam at euismod blandit, lacus arcu mattis nisi, vitae placerat nunc sapien ac quam.

Ut et lacus elit. Suspendisse ut tellus at ligula porttitor dignissim. Pellentesque nec eleifend mauris, placerat vulputate sem. Pellentesque gravida, tortor vel rhoncus interdum, sapien diam sagittis orci, vitae pharetra justo nisi ac lacus. In hac habitasse platea dictumst. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur ex libero, imperdiet a interdum sed, vestibulum ac dolor. Aliquam cursus tellus eget tellus accumsan tincidunt. Quisque vel facilisis augue. Nullam lectus arcu, consectetur sit amet feugiat quis, ultricies nec dui. Vestibulum condimentum elementum nulla sed eleifend.

Quisque suscipit augue at erat commodo, quis ultrices quam semper. Phasellus vehicula arcu nec metus malesuada, in tincidunt nisi feugiat. Mauris et rhoncus sapien. Nullam sollicitudin pellentesque venenatis. Donec tempus iaculis quam, a molestie leo. Nam ut vestibulum purus. Sed non mollis metus. Praesent et dapibus lorem. Mauris quis eros id enim malesuada facilisis non bibendum quam. Donec posuere nisl vitae tincidunt cursus. Sed ligula nunc, ultricies vel auctor quis, dictum nec mauris. Praesent commodo arcu et dui pretium, id commodo mauris pulvinar. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Maecenas lacus nunc, aliquam eget ipsum et, luctus pellentesque elit. Sed et gravida risus, vitae consectetur felis. Nam pulvinar mattis risus non ultricies.

Integer ultricies tincidunt nunc a ullamcorper. Aliquam a turpis quis sapien facilisis faucibus pharetra fringilla libero. In hac habitasse platea dictumst. Quisque turpis lorem, mollis ut dictum at, semper ut velit. Mauris vestibulum velit ut elit iaculis mollis. In hac habitasse platea dictumst. Phasellus eget turpis libero. Curabitur efficitur odio et sollicitudin pellentesque. Praesent vitae consequat neque. Aliquam enim augue, maximus vestibulum felis eget, pellentesque egestas lacus. Duis ac nibh commodo, pulvinar metus vitae, porta diam. Duis finibus convallis pharetra. Nam placerat elit et augue scelerisque, vitae mollis arcu bibendum.""";

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
          return _buildPersonCard(index, kisi, context);
        },
        separatorBuilder: (context, index) {
          if ((index + 1) % 14 == 0) {
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

  Card _buildPersonCard(int index, Kisi kisi, BuildContext context) {
    return Card(
      color: index % 2 == 0 ? Colors.white : Colors.grey,
      child: ListTile(
        title: Text(kisi.name),
        subtitle: Text(kisi.surName),
        leading: CircleAvatar(
          child: Text(kisi.id),
        ),
        onTap: () {
          if (index % 2 == 0) {
            EasyLoading.instance.backgroundColor = Colors.red;
          } else {
            EasyLoading.instance.backgroundColor = Colors.black;
          }
          EasyLoading.showToast(kisi.name);
        },
        onLongPress: () {
          showDialog(
              context: context,
              builder: (dialogContext) {
                return AlertDialog(
                  title: Text("Alert!"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      reverse: true,
                      children: [
                        Text(text),
                        ElevatedButton(
                            onPressed: () {},
                            child: Text("Okudum, Onaylıyorum")),
                        ElevatedButton(
                            onPressed: () {},
                            child: Text("Okudum, Onaylıyorum2")),
                        ElevatedButton(
                            onPressed: () {},
                            child: Text("Okudum, Onaylıyorum3")),
                      ],
                    ),
                  ),
                  actions: [
                    ButtonBar(
                      children: [
                        TextButton(onPressed: () {}, child: Text("No")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
                            child: Text("Yes")),
                        TextButton(onPressed: () {}, child: Text("No")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
                            child: Text("Yes")),
                        TextButton(onPressed: () {}, child: Text("No")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
                            child: Text("Yes")),
                      ],
                    ),
                  ],
                );
              });
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
