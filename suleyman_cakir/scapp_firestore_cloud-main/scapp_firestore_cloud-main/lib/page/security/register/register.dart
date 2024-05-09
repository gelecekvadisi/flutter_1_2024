import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scapp_firestore/services/firebase.dart';
import 'package:scapp_firestore/utils/color_schema.dart';
import 'package:svg_flutter/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final registerKey = GlobalKey<FormState>();
final emailController = TextEditingController();
final userNameController = TextEditingController();
final passwordController = TextEditingController();
final namedController = TextEditingController();
final confirmPasswordController = TextEditingController();
bool isObscure = true;
bool isTermsAccepted = false;

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
            child: Form(
              key: registerKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Welcome to us!',
                    style: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary),
                  ),
                  // Subtitle
                  Text(
                    'Hello there! Let\'s get started',
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
                  // Name
                  const SizedBox(height: 15),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: namedController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      } else if (value.length < 6) {
                        return 'Please enter a valid name';
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
                      hintText: 'Enter your name ',
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Textfield Username
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    controller: userNameController,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      } else if (value.length < 6) {
                        return 'Username must be at least 6 characters';
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
                      hintText: 'Enter your username',
                      labelText: 'Username',
                      prefixIcon: const Icon(Icons.supervised_user_circle),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Email
                  TextFormField(
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
                  const SizedBox(height: 15),
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
                  // Confirm Password
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        return 'Password is not the same';
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
                      hintText: 'Enter your confirm password ',
                      labelText: 'Confirm Pasword',
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

                  // Check box for terms and conditions

                  Row(
                    children: [
                      Checkbox(
                        value: isTermsAccepted,
                        onChanged: (value) {
                          if (value == true) {
                            setState(() {
                              isTermsAccepted = value ?? false;
                            });
                          }
                        },
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'By creating an account your aggree \n',
                          style: TextStyle(
                            color: context.colorScheme.primary,
                            fontSize: 14.0,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'to our ',
                              style: TextStyle(
                                color: context.colorScheme.primary,
                                fontSize: 14.0,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms and Conditions.',
                              style: TextStyle(
                                color: context.colorScheme.inverseSurface,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Button
                  MaterialButton(
                    onPressed: () {
                      if (registerKey.currentState!.validate()) {
                        // Perform login logic here
                        FirebaseAuthentication().registerAuth(
                            context,
                            emailController.text,
                            passwordController.text,
                            userNameController.text,
                            namedController.text);
                      } else if (isTermsAccepted != true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: context.colorScheme.error,
                            content: const Text(
                                'Please accept terms and conditions')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: context.colorScheme.error,
                            content:
                                const Text('Please enter valid credentials')));
                      }
                    },
                    color: context.colorScheme.inverseSurface,
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Register',
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
                        'Have an account?',
                        style: GoogleFonts.lato(
                          color: context.colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Perform registration logic here
                          Navigator.pushNamed(context, '/login_page');
                          // Navigator.pushNamed(context, routeName)
                        },
                        child: Text(
                          '  Login',
                          style: GoogleFonts.lato(
                            color: context.colorScheme.onSurface,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
