import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: super.key,
      children: [
        // if ("ahmet" == true)
        //   Text("ahmet == true")
        // else if ("ahmet" == false)
        //   Text("ahmet == false"),

        for (int i = 0; i < 20; i++)
          ExpansionTile(
            key: PageStorageKey("$i"),
            title: Text("Başlık $i"),
            initiallyExpanded: false,
            children: [
              Container(
                height: 200,
                color: Colors.blue,
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse facilisis risus et lacinia convallis. Cras aliquet euismod mi, nec faucibus sapien vehicula at. Donec vulputate leo purus, sit amet vestibulum."),
              ),
            ],
          ),
      ],
    );
    /* return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
      return ExpansionTile(title: Text("Başlık $index"), children: [
        Container(
          height: 200,
          color: Colors.blue,
          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse facilisis risus et lacinia convallis. Cras aliquet euismod mi, nec faucibus sapien vehicula at. Donec vulputate leo purus, sit amet vestibulum."),
        ),
      ],);
    }); */
  }
}
