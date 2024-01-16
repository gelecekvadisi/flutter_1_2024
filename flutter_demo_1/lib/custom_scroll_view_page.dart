//  SingleChildScrollView
//  ListView
//  GirdView
//  CustomScrollView

import 'dart:math';

import 'package:flutter/material.dart';

class CustomScrollViewPage extends StatelessWidget {
  const CustomScrollViewPage({super.key});

  final String imageUrl =
      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // title: Text("Hello World!"),
            // centerTitle: true,
            backgroundColor: Colors.redAccent.shade400,
            expandedHeight: 200,
            floating: true,
            pinned: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(imageUrl, fit: BoxFit.cover),
              title: Text(
                "Sliver App Bar",
              ),
              centerTitle: true,
              titlePadding: EdgeInsetsDirectional.only(start: 0, bottom: 16),
            ),
          ),
          // SliverList(
          //   delegate: SliverChildListDelegate(containerList),
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  color: Color.fromARGB(
                    255,
                    Random().nextInt(256),
                    Random().nextInt(256),
                    Random().nextInt(256),
                  ),
                  height: 200,
                  child: Center(
                    child: Text("${index + 1}. Container",
                        style: TextStyle(fontSize: 24)),
                  ),
                );
              },
              childCount: 10,
            ),
          ),
          SliverVisibility(
            visible: false,
            sliver: SliverFixedExtentList(
              itemExtent: 300,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    color: Color.fromARGB(
                      255,
                      Random().nextInt(256),
                      Random().nextInt(256),
                      Random().nextInt(256),
                    ),
                    height: 200,
                    child: Center(
                      child: Text("${index + 1}. Container",
                          style: TextStyle(fontSize: 24)),
                    ),
                  );
                },
                childCount: 10,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate(
                [
                  ...containerList,
                  ...containerList,
                  ...containerList,
                  ...containerList,
                  ...containerList,
                  ...containerList,
                ],
              ),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            ),
          ),

        ],
      ),
    );
  }

  List<Widget> get containerList {
    return [
      Container(
        color: Colors.green,
        height: 200,
        child: Center(
          child: Text("1. Container", style: TextStyle(fontSize: 24)),
        ),
      ),
      Container(
        color: Colors.blue,
        height: 200,
        child: Center(
          child: Text("2. Container", style: TextStyle(fontSize: 24)),
        ),
      ),
      Container(
        color: Colors.red,
        height: 200,
        child: Center(
          child: Text("3. Container", style: TextStyle(fontSize: 24)),
        ),
      ),
      Container(
        color: Colors.purple,
        height: 200,
        child: Center(
          child: Text("4. Container", style: TextStyle(fontSize: 24)),
        ),
      ),
      Container(
        color: Colors.yellow,
        height: 200,
        child: Center(
          child: Text("5. Container", style: TextStyle(fontSize: 24)),
        ),
      ),
    ];
  }
}
