// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scapp_firestore/utils/color_schema.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void showPostOptions(
      BuildContext context, String postId, Map<String, dynamic> data) {
    final List<String> options = ['Edit Post', 'Delete Post'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(options[index]),
                  onTap: () {
                    Navigator.pop(context);
                    if (index == 0) {
                      String currentText = data['text'];
                      editPost(context, postId, currentText);
                    } else if (index == 1) {
                      _deletePost(context, postId,
                          FirebaseAuth.instance.currentUser!.uid);
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void editPost(BuildContext context, String postId, String currentText) {
    final TextEditingController textEditingController =
        TextEditingController(text: currentText);

    String? newPostText;
    File? newImageFile;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textEditingController,
                maxLines: null,
                onChanged: (text) {
                  newPostText = text;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your new post...',
                  labelText: 'Post',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      newImageFile = File(pickedFile.path);
                    });
                  }
                },
                child: const Text('Select Image'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _saveChanges(postId, newPostText, newImageFile);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveChanges(
      String postId, String? newPostText, File? newImageFile) async {
    try {
      final Map<String, dynamic> updateData = {};
      if (newPostText != null && newPostText.isNotEmpty) {
        updateData['text'] = newPostText;
      }
      if (newImageFile != null) {
        // Yeni bir fotoğraf seçildiyse, depolama alanına yükle
        final String imageUrl = await uploadImage(newImageFile);
        updateData['image_url'] = imageUrl;
      }

      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update(updateData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post updated successfully!'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update post: $e'),
        ),
      );
    }
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('images');
      final TaskSnapshot uploadTask = await storageRef.putFile(imageFile);
      final String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Image upload error: $e');
      return '';
    }
  }

  void _deletePost(BuildContext context, String postId, String userId) async {
    if (FirebaseAuth.instance.currentUser != null) {
      if (FirebaseAuth.instance.currentUser!.uid == userId) {
        try {
          await FirebaseFirestore.instance
              .collection('posts')
              .doc(postId)
              .delete();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Post deleted successfully!'),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete post: $e'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You are not authorized to delete this post.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You need to be logged in to delete this post.'),
        ),
      );
    }
  }

  final User? user = FirebaseAuth.instance.currentUser;
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
      appBar: AppBar(
        elevation: 10,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.email)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final userData = snapshot.data!.data()!;
                    final imageUrl = userData['profile_photo_url'] as String?;
                    final username = userData['username'] as String?;
                    final named = userData['named'] as String?;

                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (pickedFile != null) {
                                _uploadImage(File(pickedFile.path));
                              }
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: imageUrl != null
                                  ? NetworkImage(imageUrl)
                                  : const AssetImage(
                                      'assets/images/default_profile.png',
                                    ) as ImageProvider,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              Text(
                                named ?? 'Named',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                username ?? 'Username',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Post sayısı
                              FutureBuilder<QuerySnapshot>(
                                future: FirebaseFirestore.instance
                                    .collection('posts')
                                    .where('user_id', isEqualTo: user!.uid)
                                    .get(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    final postCount =
                                        snapshot.data!.docs.length;
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text('$postCount'),
                                              const Text('posts'),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          const Column(
                                            children: [
                                              Text('0'),
                                              Text('followers')
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          const Column(
                                            children: [
                                              Text('0'),
                                              Text('followed')
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const Text('No data available.');
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Text('No data available.');
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Your Posts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .where('user_id', isEqualTo: user!.uid)
                      .orderBy('timestamp', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final posts = snapshot.data!.docs;
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String postId = document.id;
                          final post = posts[index];
                          final text = post['text'] as String?;
                          final username = post['username'] as String?;
                          final named = post['named'] as String?;
                          final timestamp = post['timestamp'] as Timestamp?;
                          final Map<String, dynamic> postData =
                              post.data() as Map<String, dynamic>;
                          final imageUrl = postData.containsKey('image_url')
                              ? postData['image_url'] as String
                              : null;
                          final profileImageUrl =
                              postData.containsKey('profile_photo_url')
                                  ? postData['profile_photo_url'] as String
                                  : null;

                          return Card(
                            color: context.colorScheme.inversePrimary,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            elevation: 5,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: profileImageUrl != null
                                        ? NetworkImage(profileImageUrl)
                                        : const AssetImage(
                                            'assets/images/default_profile.png',
                                          ) as ImageProvider,
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            named ?? 'Username',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            username ?? 'Username',
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.more_horiz),
                                        onPressed: () {
                                          showPostOptions(
                                              context, postId, data);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                if (imageUrl != null)
                                  Image.network(
                                    imageUrl,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                if (text != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$username:',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          text,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12),
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
                                            color: context.colorScheme.shadow
                                                .withOpacity(0.5),
                                            Icons.favorite_outline_outlined,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          color: context.colorScheme.shadow
                                              .withOpacity(0.5),
                                          icon: const Icon(
                                              Icons.mode_comment_outlined),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          color: context.colorScheme.shadow
                                              .withOpacity(0.5),
                                          icon:
                                              const Icon(Icons.share_outlined),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.bookmark_border_outlined,
                                            color: context.colorScheme.shadow
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        Text(
                                          calculateTimeDifference(
                                              timestamp?.toDate() ??
                                                  DateTime.now()),
                                          style: TextStyle(
                                              fontSize: 12,
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
                    } else {
                      return const Text('No data available.');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      final storage = FirebaseStorage.instance;
      final reference = storage.ref().child(
            "profile_photos/${user!.email}/profile_photo.jpg",
          );
      await reference.putFile(imageFile);
      final imageUrl = await reference.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.email)
          .update({'profile_photo_url': imageUrl});

      setState(() {}); // State'i yenilemek için setState çağrısı
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
