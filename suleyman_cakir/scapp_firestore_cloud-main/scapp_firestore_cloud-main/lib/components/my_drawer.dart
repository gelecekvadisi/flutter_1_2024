import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scapp_firestore/services/firebase.dart';
import 'package:scapp_firestore/utils/color_schema.dart';

class MyDrawer extends StatefulWidget {
  final Function(int) onItemSelected;
  final int currentIndex;

  const MyDrawer({
    super.key,
    required this.onItemSelected,
    required this.currentIndex,
  });

  @override
  State<MyDrawer> createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  int? currentIndex;
  String? userName = '';
  String? userPhotoUrl = '';
  String? name = '';

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    _fetchUserData(); // Kullanıcı verilerini çekmek için
  }

  Future<void> _fetchUserData() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();

    if (userDoc.exists) {
      setState(() {
        userName = userDoc['username'] ?? '';
        userPhotoUrl = userDoc['profile_photo_url'] ?? '';
        name = userDoc['named'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.colorScheme.onSurfaceVariant,
      elevation: 10,
      child: DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onItemSelected(4);
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(100),
                      image: userPhotoUrl != null && userPhotoUrl!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(userPhotoUrl!),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage(
                                  'assets/images/default_profile.png'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                // name
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    name ?? '',
                    style: TextStyle(
                      color: context.colorScheme.shadow,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Username
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    '@${userName ?? ''}',
                    style: TextStyle(
                      color: context.colorScheme.shadow.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ),
                // Button List
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.home,
                          color: context.colorScheme.onSecondaryContainer,
                        ),
                        title: Text(
                          'H O M E',
                          style: TextStyle(
                            fontWeight: (currentIndex == 0)
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          _handleItemSelected(0);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.search,
                          color: context.colorScheme.onSecondaryContainer,
                        ),
                        title: Text(
                          'S E A R C H',
                          style: TextStyle(
                            fontWeight: (currentIndex == 1)
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          _handleItemSelected(1);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.add,
                          color: context.colorScheme.onSecondaryContainer,
                        ),
                        title: Text(
                          'A D D',
                          style: TextStyle(
                            fontWeight: (currentIndex == 2)
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          _handleItemSelected(2);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.supervised_user_circle_sharp,
                          color: context.colorScheme.onSecondaryContainer,
                        ),
                        title: Text(
                          'U S E R S',
                          style: TextStyle(
                            fontWeight: (currentIndex == 3)
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          _handleItemSelected(3);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person_2_outlined,
                          color: context.colorScheme.onSecondaryContainer,
                        ),
                        title: Text(
                          'P R O F I L E',
                          style: TextStyle(
                            fontWeight: (currentIndex == 4)
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          _handleItemSelected(4);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Sign Out Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                children: [
                  const Icon(Icons.logout),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      FirebaseAuthentication().signOut(context);
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleItemSelected(int index) {
    setState(() {
      currentIndex = index;
    });
    widget.onItemSelected(index);
    Navigator.pop(context); // Drawer'ı kapatmak için
  }
}
