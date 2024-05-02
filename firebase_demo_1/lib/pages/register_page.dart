import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kaydol"),
      ),
      body: Column(
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
                OutlinedButton(onPressed: () {}, child: const Text("Kaydol")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildFields() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Kullanıcı adı",
          ),
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "E-Posta",
          ),
        ),
        TextField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Parola",
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePhoto() {
    return InkWell(
      onTap: () async {
        try {
          var picker = ImagePicker();
          var xFile = await picker.pickImage(source: ImageSource.gallery);

          if (xFile == null) {
            debugPrint("Dosya seçilmedi!");
            return;
          }

          File file = File(xFile.path);
          String dosyaUzantisi = file.path.split(".").last;
          debugPrint("Seçilen dosya: ${file.path}");

          var storage = FirebaseStorage.instance;
          Reference fileReference =
              storage.ref().child("profile_photo/user1.$dosyaUzantisi");
          await fileReference.putFile(file);
          debugPrint(
              "Dosya Firebase'e yüklendi! Ref: ${fileReference.fullPath}");
          imageUrl = await fileReference.getDownloadURL();
          debugPrint("Resim url adresi: $imageUrl");

          setState(() {});
        } catch (e) {
          debugPrint(e.toString());
        }
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
          image: (imageUrl == null)
              ? null
              : DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                ),
        ),
        child: (imageUrl == null)
            ? const Center(
                child: Text("Profil resmi"),
              )
            : null,
      ),
    );
  }
}
