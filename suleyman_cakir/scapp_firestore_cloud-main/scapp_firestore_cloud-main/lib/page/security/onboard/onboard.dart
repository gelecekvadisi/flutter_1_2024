import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:scapp_firestore/utils/color_schema.dart';

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: LottieBuilder.asset('assets/lottie/welcome.json',
                      repeat: false),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Welcome to the app!',
                  style: GoogleFonts.lato().copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                    textAlign: TextAlign.center,
                    'Join us now to step into a brand new experience! If you already have an account, you can log in and continue your journey where you left off. If you are not a member yet, we invite you to join our family!'),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
              child: Column(
                children: [
                  MaterialButton(
                    height: 50,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minWidth: double.infinity,
                    color: context.colorScheme.primary,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login_page');
                    },
                    child: Text(
                      'Sign in with password',
                      style: GoogleFonts.lato().copyWith(
                          letterSpacing: 1,
                          color: context.colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    height: 50,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minWidth: double.infinity,
                    color: context.colorScheme.onSecondary,
                    onPressed: () {
                      Navigator.pushNamed(context, '/register_page');
                    },
                    child: Text(
                      'Don\'t have a account',
                      style: GoogleFonts.lato().copyWith(
                          letterSpacing: 1,
                          color: context.colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
