// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:scapp_firestore/page/screen/follow.dart';
import 'package:scapp_firestore/page/screen/nfollow.dart';

import 'package:scapp_firestore/utils/color_schema.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // İki sekme kullanacağımızı belirtiyoruz
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: context.colorScheme.shadow,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: context.colorScheme.shadow,
            ),
          ),
          title: const SizedBox(
            width: 120,
            height: 120,
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'For You',
              ),
              Tab(
                text: 'Following',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NFollowPage(),
            FollowPage(),
          ],
        ),
      ),
    );
  }
}
