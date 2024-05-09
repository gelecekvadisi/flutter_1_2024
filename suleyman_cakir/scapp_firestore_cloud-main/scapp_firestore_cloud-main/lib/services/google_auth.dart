// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleServiceAuthentication {
  // Google Sign in
  signInWithGoogleService() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // auth details from request

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credentials for user

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  googleSignIn(BuildContext context) async {
    try {
      await GoogleServiceAuthentication().signInWithGoogleService();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sucess to Google')));
      await Future.delayed(const Duration(seconds: 5));
      await Navigator.pushNamedAndRemoveUntil(
          context, '/home_view_page', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Signing in with Google has been abandoned!')));
    }
  }
}
