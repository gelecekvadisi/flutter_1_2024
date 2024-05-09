import 'package:flutter/material.dart';
import 'package:scapp_firestore/page/details/details.dart';
import 'package:scapp_firestore/page/home/on_home_page.dart';
import 'package:scapp_firestore/page/screen/add.dart';
import 'package:scapp_firestore/page/screen/home.dart';
import 'package:scapp_firestore/page/screen/profile.dart';
import 'package:scapp_firestore/page/screen/search.dart';
import 'package:scapp_firestore/page/screen/splash_screen.dart';
import 'package:scapp_firestore/page/screen/users.dart';
import 'package:scapp_firestore/page/security/login/login.dart';
import 'package:scapp_firestore/page/security/onboard/onboard.dart';
import 'package:scapp_firestore/page/security/register/register.dart';
import 'package:scapp_firestore/services/auth.dart';

Map<String, Widget Function(BuildContext context)> routes = {

  '/': (context) => const SplashScreen(),
  '/auth_page': (context) => const AuthPage(),
  '/onboard_page': (context) => const OnBoardPage(),
  '/login_page': (context) => const LoginPage(),
  '/register_page': (context) => const RegisterPage(),
  '/home_page': (context) => const HomePage(),
  '/search_page': (context) => const SearchPage(),
  '/add_page': (context) => const AddPage(),
  '/users_page': (context) => const UsersPage(),
  '/profile_page': (context) => const ProfilePage(),
  '/home_view_page': (context) => const HomeViewScreen(
        selectedIndex: 0,
      ),
  '/user_details': (context) => const DetailsPage(),
};
