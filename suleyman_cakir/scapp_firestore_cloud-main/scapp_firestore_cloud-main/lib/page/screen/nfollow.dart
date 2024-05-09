// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scapp_firestore/page/details/details.dart';
import 'package:scapp_firestore/page/screen/add.dart';
import 'package:scapp_firestore/utils/color_schema.dart';

class NFollowPage extends StatefulWidget {
  const NFollowPage({super.key});

  @override
  State<NFollowPage> createState() => _NFollowPageState();
}

class _NFollowPageState extends State<NFollowPage> {
  String calculateTimeDifference(DateTime postTime) {
    final now = DateTime.now();
    final difference = now.difference(postTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} S';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}M';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}H';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm:ss').format(postTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blue.shade200,
        elevation: 5,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Card(
                color: context.colorScheme.inversePrimary,
                margin: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          data['profile_photo_url'],
                        ),
                      ),
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                email: data['email'],
                                username: data['username'],
                                imageUrl: data['profile_photo_url'],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          data['named'] ?? 'Unknown User',
                          style: TextStyle(
                            color: context.colorScheme.shadow,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        '@${data['username']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colorScheme.shadow.withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_horiz,
                          color: context.colorScheme.shadow,
                        ),
                      ),
                    ),
                    if (data.containsKey('image_url'))
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Image.network(
                          data['image_url'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            '${data['username']}:',
                            style: TextStyle(
                              color: context.colorScheme.shadow,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${data['text']}',
                            style: TextStyle(
                              color: context.colorScheme.shadow,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                color:
                                    context.colorScheme.shadow.withOpacity(0.5),
                                Icons.favorite_outline_outlined,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              color:
                                  context.colorScheme.shadow.withOpacity(0.5),
                              icon: const Icon(Icons.mode_comment_outlined),
                            ),
                            IconButton(
                              onPressed: () {},
                              color:
                                  context.colorScheme.shadow.withOpacity(0.5),
                              icon: const Icon(Icons.share_outlined),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.bookmark_border_outlined,
                                color:
                                    context.colorScheme.shadow.withOpacity(0.5),
                              ),
                            ),
                            Text(
                              calculateTimeDifference(
                                  data['timestamp'].toDate()),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: context.colorScheme.shadow
                                      .withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
