import 'package:flutter/material.dart';
import 'package:flutter_widgets_1/pages/camera_page.dart';
import 'package:flutter_widgets_1/pages/feed_page.dart';
import 'package:flutter_widgets_1/pages/search_page.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../widgets/home_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedBottomIndex = 0;

  List<Widget> pageList = [
    // CameraPage(),
    // FeedPage(),
    // SearchPage(),
    CameraPage(key: PageStorageKey("camera_page")),
    FeedPage(key: PageStorageKey("feed_page"),),
    SearchPage(key: PageStorageKey("search_page"),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: const HomeDrawer(),
      // endDrawer: const HomeDrawer(),
      bottomNavigationBar: _buildBottomNavBar(),
      body: pageList[selectedBottomIndex],
    );
  }

  /* Center _fontKullanimi() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Hello World',
            style: TextStyle(
                fontFamily: "NotoSerif",
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal),
          ),
          Text(
            'Hello World',
            style: GoogleFonts.limelight().copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  } */

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedBottomIndex,
      onTap: (index) {
        setState(() {
          selectedBottomIndex = index;
        });
      },
      // backgroundColor: Colors.red,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: "Kamera",
            backgroundColor: Colors.brown, tooltip: "Kamera Sayfası", ),
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Ana Sayfa",
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Keşfet",
            backgroundColor: Colors.blue),
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.video_call),
        //     label: "Reels",
        //     backgroundColor: Colors.green),
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.person),
        //     label: "Profil",
        //     backgroundColor: Colors.purple),
      ],
    );
  }
}
