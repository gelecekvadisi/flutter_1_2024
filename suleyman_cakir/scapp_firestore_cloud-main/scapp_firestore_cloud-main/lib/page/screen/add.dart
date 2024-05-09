// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  late TextEditingController _textEditingController;
  File? _imageFile;

  bool isWriting = false;

  int? currentIndex;
  String? userName = '';
  String? userPhotoUrl = '';
  String? name = '';

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
  void initState() {
    super.initState();
    _fetchUserData();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      setState(() {
        isWriting = _textEditingController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: MaterialButton(
                color: isWriting ? Colors.blue : Colors.blue.shade200,
                onPressed: () {
                  isWriting ? _uploadPost() : null;
                },
                child: const Text('Post')),
          )
        ],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.start,
              'Cancel',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              autofocus: true,
              controller: _textEditingController,
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: CircleAvatar(
                      backgroundImage: userPhotoUrl != null
                          ? NetworkImage(userPhotoUrl!)
                          : null,
                      radius: 20.0,
                    ),
                  ),
                  hintText: 'What\'s going on?',
                  border: InputBorder.none),
              maxLines: null,
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.add_a_photo,
                        size: 50.0,
                        color: Colors.grey,
                      ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadPost() async {
    if (_textEditingController.text.isEmpty) {
      return;
    }

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.email)
            .get();
        if (userDoc.exists) {
          final username = userDoc['username'] as String;
          final profilePhotoUrl = userDoc['profile_photo_url'] as String;
          final email = userDoc['email'] as String;
          final name = userDoc['named'] as String;

          // Firestore'a post ekleme
          final CollectionReference posts =
              FirebaseFirestore.instance.collection('posts');

          // Yeni bir post belgesi oluştur
          DocumentReference postRef = await posts.add({
            'text': _textEditingController.text,
            'timestamp': FieldValue.serverTimestamp(),
            'user_id': currentUser.uid,
            'username': username,
            'profile_photo_url': profilePhotoUrl,
            'email': email,
            'named': name
          });

          // Eğer bir fotoğraf varsa, Firebase Storage'a yükle
          if (_imageFile != null) {
            final storageRef = FirebaseStorage.instance
                .ref()
                .child('post_images')
                .child('${postRef.id}.jpg');
            await storageRef.putFile(_imageFile!);
            final imageUrl = await storageRef.getDownloadURL();
            // Oluşturulan post belgesine fotoğraf URL'sini ekle
            await postRef.update({'image_url': imageUrl});
          }

          // Formu temizle
          _textEditingController.clear();
          setState(() {
            _imageFile = null;
          });

          // Başarılı bir şekilde post eklendiğine dair mesaj göster
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Post successfully added!')),
          );
          Navigator.pushNamedAndRemoveUntil(
              context, '/home_view_page', (route) => false);
        }
      }
    } catch (e) {
      // Hata durumunda kullanıcıya bilgi ver
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add post: $e')),
      );
    }
  }
}
