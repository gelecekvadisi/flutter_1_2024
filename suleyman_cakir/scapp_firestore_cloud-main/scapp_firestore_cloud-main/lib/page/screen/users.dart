import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scapp_firestore/page/details/details.dart';
import 'package:scapp_firestore/utils/color_schema.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        elevation: 10,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data() as Map<String, dynamic>;
              final username = user['username'] as String?;
              final email = user['email'] as String?;
              final imageUrl = user['profile_photo_url'] as String?;
              final named = user['named'] as String?;

              return ListTile(
                leading: CircleAvatar(
                  radius: 50,
                  backgroundImage: imageUrl != null
                      ? NetworkImage(imageUrl)
                      : const AssetImage(
                          'assets/images/default_profile.png',
                        ) as ImageProvider,
                ),
                title: Text(username ?? ''),
                subtitle: Text(
                  email ?? '',
                  style: TextStyle(color: context.colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        username: username,
                        email: email,
                        imageUrl: imageUrl,
                        named: named,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
