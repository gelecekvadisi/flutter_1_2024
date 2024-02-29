import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // DrawerHeader(child: Container()),
          UserAccountsDrawerHeader(
            accountName: const Text("Furkan Yağmur"),
            accountEmail: const Text("furkan@gmail.com"),
            currentAccountPicture: const CircleAvatar(
                // borderRadius: BorderRadius.circular(1000),
                backgroundImage: NetworkImage(
              "https://picsum.photos/300",
            )),
            otherAccountsPictures: [
              InkWell(
                onTap: () {},
                child: const CircleAvatar(
                    // borderRadius: BorderRadius.circular(1000),
                    backgroundImage: NetworkImage(
                  "https://picsum.photos/300",
                )),
              ),
              const CircleAvatar(
                  // borderRadius: BorderRadius.circular(1000),
                  backgroundImage: NetworkImage(
                "https://picsum.photos/300",
              ))
              /* CircleAvatar(
                  child: Icon(Icons.logout_outlined),) */
            ],
          ),
          Expanded(
            child: ListView(
              children: const [
                ListTile(title: Text("Ana Sayfa"), leading: Icon(Icons.home)),
                ListTile(title: Text("Ayarlar"), leading: Icon(Icons.settings)),
                ListTile(title: Text("İletişim"), leading: Icon(Icons.phone)),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
