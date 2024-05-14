// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:scapp_firestore/components/my_drawer.dart';
import 'package:scapp_firestore/page/screen/add.dart';
import 'package:scapp_firestore/page/screen/home.dart';
import 'package:scapp_firestore/page/screen/profile.dart';
import 'package:scapp_firestore/page/screen/search.dart';
import 'package:scapp_firestore/page/screen/users.dart';
import 'package:scapp_firestore/utils/color_schema.dart';

class HomeViewScreen extends StatefulWidget {
  final selectedIndex;
  const HomeViewScreen({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<HomeViewScreen> createState() => _HomeViewScreenState();
}

class _HomeViewScreenState extends State<HomeViewScreen> {
  int _currentIndex = 0;
  @override
  void initState() {
    _currentIndex = widget.selectedIndex;
    super.initState();
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const SearchPage(),
    const AddPage(),
    const UsersPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      drawer: MyDrawer(
        currentIndex: _currentIndex,
        onItemSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_sharp),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: context.colorScheme.primary,
        unselectedItemColor: context.colorScheme.secondary,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
