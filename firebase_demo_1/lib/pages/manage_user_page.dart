import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ManageUserPage extends StatefulWidget {
  ManageUserPage({super.key});

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  late FirebaseAuth _firebaseAuth;

  String _email = "odev.gelecekvadisi@gmail.com";
  String _password = "1234567890";

  @override
  void initState() {
    super.initState();
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseAuth.authStateChanges().listen((user) {
      if (user == null) {
        debugPrint("Kullanıcı oturumu kapalı!");
      } else {
        debugPrint("Kullanıcı bilgileri: $user");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage User Page"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: _registerUser,
              child: const Text("Create User"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: _signIn,
              child: const Text("Sign In"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: _signOut,
              child: const Text("Sign Out"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              onPressed: _verifyEmail,
              child: const Text("Verify Email"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              onPressed: _userDelete,
              child: const Text("Delete Account"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
              ),
              onPressed: _updatePassword,
              child: const Text("Update Password"),
            ),
          ],
        ),
      ),
    );
  }

  _registerUser() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      debugPrint("Kullanıcı oluşturuldu!");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _signIn() async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      debugPrint("Oturum açıldı!");
      debugPrint(credential.user.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _signOut() async {
    try {
      await _firebaseAuth.signOut();
      debugPrint("Oturum Kapatıldı!");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _verifyEmail() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        debugPrint("Doğrulama maili \"${user.email}\" adresine gönderildi");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _userDelete() {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        user.delete();
        debugPrint("Kullancı hesabı silindi!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _updatePassword() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.reauthenticateWithCredential(EmailAuthProvider.credential(
          email: _email,
          password: _password,
        ));
        await user.updatePassword("1234567890");
        debugPrint("Parola Güncellendi!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
