import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scapp_firestore/services/firebase.dart';
import 'package:scapp_firestore/utils/color_schema.dart';
import 'package:svg_flutter/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

final loginKey = GlobalKey<FormState>();
bool isObscure = true;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
            child: Form(
              key: loginKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary),
                  ),
                  // Subtitle
                  Text(
                    'Hello again! You\'ve been missed',
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: context.colorScheme.secondary),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // İmage
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: SvgPicture.asset('assets/svg/login.svg'),
                  ),
                  const SizedBox(height: 40),
                  // Textfield Email
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: context.colorScheme.onInverseSurface,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: context.colorScheme.error),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: context.colorScheme.error),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: context.colorScheme.primary)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: context.colorScheme.primary)),
                      hintText: 'Enter your email ',
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Textfield Password
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 10) {
                        return 'Please enter a minimum of 10 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: context.colorScheme.onInverseSurface,
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: context.colorScheme.error),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: context.colorScheme.error),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: context.colorScheme.primary)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: context.colorScheme.primary)),
                      hintText: 'Enter your password ',
                      labelText: 'Pasword',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: isObscure
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                    obscureText: isObscure,
                  ),
                  const SizedBox(height: 20),
                  // Forgot Password

                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Perform forgot password logic here
                        },
                        child: Text(
                          'Forgot Password ?',
                          style: GoogleFonts.lato(
                            color: context.colorScheme.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )),
                  const SizedBox(height: 20),

                  // Button
                  MaterialButton(
                    onPressed: () {
                      if (loginKey.currentState!.validate()) {
                        // Perform login logic here
                        FirebaseAuthentication().signIn(emailController.text,
                            passwordController.text, context);
                      }
                    },
                    color: context.colorScheme.inverseSurface,
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Dont have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: GoogleFonts.lato(
                          color: context.colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Perform registration logic here
                          Navigator.pushNamed(context, '/register_page');
                          // Navigator.pushNamed(context, routeName)
                        },
                        child: Text(
                          '  Register',
                          style: GoogleFonts.lato(
                            color: context.colorScheme.onSurface,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // divider or
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'OR',
                            style: GoogleFonts.lato(),
                          )),
                      const Expanded(
                        child: Divider(),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Social Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: GestureDetector(
                            onTap: () {
                              /*  GoogleServiceAuthentication().googleSignIn(context); */
                            },
                            child: SvgPicture.asset('assets/svg/google.svg')),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/svg/apple.png')),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
