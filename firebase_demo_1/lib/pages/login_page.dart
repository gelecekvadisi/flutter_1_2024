import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;

  String email = "";
  String password = "";

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giriş Yap"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "E-Posta",
                  ),
                  // onChanged: (value) => email = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "E-Posta alanı boş bırakılamaz.";
                    } else if (!value.contains("@")) {
                      return "Girdiğiniz e-posta adresi hatalı";
                    }

                    return null;
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Parola",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  obscureText: !passwordVisible,
                  // obscuringCharacter: "*",
                  // onChanged: (value) => password = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Parola alanı boş bırakılamaz.";
                    } else if (value.length < 6) {
                      return "Parolanız en az 6 karakterden oluşmalıdır.";
                    }

                    return null;
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: const Text("Giriş Yap"),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text("Veya Oturum Açın"),
                const SizedBox(
                  height: 16,
                ),
                TextButton.icon(
                  onPressed: () {
                    _signInWithGoogle();
                  },
                  icon: Image.asset("asset/google.png", height: 32,),
                  label: const Text("Google"),
                ),
                ElevatedButton(onPressed: () async {
                  await GoogleSignIn().signOut();
                  await FirebaseAuth.instance.signOut();
                }, child: Text("Google Sign Out")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("Oturum açıldı! ${FirebaseAuth.instance.currentUser?.email}");
    }
  }

  void _signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      debugPrint("Geçerli bir google hesabı seçilmedi!");
      return;
    }

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    var _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signInWithCredential(credential);
    debugPrint("Kullanıcı oturumu açıldı: ${_firebaseAuth.currentUser?.email}");

  }
}
