// Firebase Authentication

// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scapp_firestore/page/security/register/register.dart';
import 'package:scapp_firestore/utils/color_schema.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kullanıcıyı kaydetme

  Future<void> registerAuth(BuildContext context, String email, String password,
      String username, String named) async {
    try {
      // Kullanıcıyı kaydetmeye çalış
      UserCredential? userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kullanıcıyı Firestore'a kaydet
      createUserDocument(userCredential);

      // Doğrulama e-postası gönder
      User? user = _auth.currentUser;
      if (user != null) {
        await user.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: context.colorScheme.primary,
            content: const Text('Email verification email has been sent.')));
        Navigator.pushNamed(context, '/login_page');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Eğer e-posta adresi zaten kullanımdaysa, bu durumda kullanıcı bu e-posta adresiyle zaten kayıtlıdır

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: context.colorScheme.error,
            content: const Text('The email address is already in use.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: context.colorScheme.error,
            content: const Text('Hoopp Email verification error!')));
      }
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      // E-posta ve şifre doğrulaması yap
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // E-posta doğrulanmış mı kontrol et
      User? user = result.user;
      if (user != null && user.emailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: context.colorScheme.primary,
            content: const Text('Login successful')));
        await Future.delayed(const Duration(seconds: 5));
        await Navigator.pushNamedAndRemoveUntil(
          context,
          '/home_view_page',
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email is not verified and cannot log in.')));
        await Future.delayed(const Duration(seconds: 5));
      }
    } on FirebaseAuthException catch (e) {
      // FirebaseAuthException yakalama
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: context.colorScheme.error,
            content: const Text('User not found!')));
        await Future.delayed(const Duration(seconds: 5));
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: context.colorScheme.error,
            content: const Text('Wrong password!')));
        await Future.delayed(const Duration(seconds: 5));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: context.colorScheme.error,
            content: const Text(
                'Whoopp, something went wrong\nPlease review the information!')));
        await Future.delayed(const Duration(seconds: 5));
      }
    }
  }

  signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: context.colorScheme.primary,
          content: const Text('Successfully logged out')));

      await Navigator.pushNamedAndRemoveUntil(
          context, '/login_page', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: context.colorScheme.error,
          content: const Text('There was a problem logging out of Hoop!')));
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  accoutDeleted(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: context.colorScheme.primary,
            content: const Text('User deleted!')));

        await Future.delayed(const Duration(seconds: 5));
        await Navigator.pushNamedAndRemoveUntil(
            context, '/register_page', (route) => false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: context.colorScheme.primary,
          content: const Text('There was a problem deleting the Hoop user!')));
    }
  }

  // Kullanıcıyı Firestore'a kaydetme
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await _firestore.collection('users').doc(userCredential.user!.email).set({
        'email': userCredential.user!.email,
        'username': userNameController.text,
        'named': namedController.text,
        'createdAt': Timestamp.now(),
      });
    }
  }
}
