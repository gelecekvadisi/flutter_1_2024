import 'package:flutter/material.dart';

import 'camera_page.dart';
import 'feed_page.dart';
import 'search_page.dart';

class TabBarPage extends StatefulWidget {
  TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  List<Widget> pageList = [
    CameraPage(),
    FeedPage(
      key: PageStorageKey("feed_page"),
    ),
    SearchPage(),
  ];

  // late TabController _tabController;

  // @override
  // void initState() {
  //   _tabController = TabController(length: pageList.length, vsync: this);
  //   _tabController.addListener(() {
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pageList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tab Bar Page"),
          bottom: TabBar(
            // controller: _tabController,
            // onTap: (index) {
            //   setState(() {});
            // },
            tabs: [
              Tab(child: Text("Kamera Sayfası")),
              Tab(child: Text("Ana Sayfa")),
              Tab(child: Text("Arama Sayfası")),
            ],
          ),
        ),
        // body: pageList[_tabController.index],
        body: TabBarView(
          children: pageList,
          // controller: _tabController,
        ),
      ),
    );
  }
}
