import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? imageUrl;
  File? imageFile;

  String? userName, email, password;

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kaydol"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildProfilePhoto(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: _buildFields(),
                    ),
                    OutlinedButton(
                        onPressed: () {
                          _registerUser();
                        },
                        child: const Text("Kaydol")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser() async {
    if (_formKey.currentState!.validate() && imageFile != null) {
      _formKey.currentState!.save();

      String userId = await _createUserOnFirebaseAuth(email!, password!);
      await _savePhoto(userId, imageFile!);
      await _createUserOnFirestore(userId: userId, userName: userName!);
      debugPrint("Kullanıcını tüm verileri kaydedildi!");
    }
  }

  Future<String> _createUserOnFirebaseAuth(
      String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    // credential.user!.updatePhotoURL(photoURL);
    // auth.currentUser.photoURL;
    return credential.user!.uid;
  }

  _createUserOnFirestore({
    required String userId,
    required String userName,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("user_info").doc(userId).set({
      "userName": userName,
      "photoUrl": imageUrl,
      "userId": userId,
      "tc": "4789021342098",
      "address": "Çobançeşme mah. Bahçelievler/İstanbul",
    });
  }

  Widget _buildFields() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Kullanıcı adı",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Bu alan boş bırakılamaz.";
              }
              return null;
            },
            onSaved: (value) {
              userName = value;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "E-Posta",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Bu alan boş bırakılamaz.";
              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return "Hatalı veya eksik e-posta girdiniz.";
              }
              return null;
            },
            onSaved: (value) {
              email = value;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Parola",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Bu alan boş bırakılamaz.";
              } else if (value.length < 6) {
                return "Parola 6 karakterden kısa olamaz.";
              }
              return null;
            },
            onSaved: (value) {
              password = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhoto() {
    return InkWell(
      onTap: () async {
        _pickPhoto();
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(20),
          image: (imageFile == null)
              ? null
              : DecorationImage(
                  image: FileImage(imageFile!),
                  fit: BoxFit.cover,
                ),
        ),
        child: (imageFile == null)
            ? const Center(
                child: Text("Profil resmi"),
              )
            : null,
      ),
    );
  }

  _pickPhoto() async {
    try {
      var picker = ImagePicker();
      XFile? xFile = await picker.pickImage(source: ImageSource.gallery);

      if (xFile == null) {
        debugPrint("Dosya seçilmedi!");
        return;
      }

      imageFile = File(xFile.path);

      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _savePhoto(String userId, File file) async {
    String dosyaUzantisi = file.path.split(".").last;
    debugPrint("Seçilen dosya: ${file.path}");

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference fileReference =
        storage.ref().child("profile_photo/$userId.$dosyaUzantisi");
    await fileReference.putFile(file);
    debugPrint("Dosya Firebase'e yüklendi! Ref: ${fileReference.fullPath}");
    imageUrl = await fileReference.getDownloadURL();
    debugPrint("Resim url adresi: $imageUrl");
  }
}
