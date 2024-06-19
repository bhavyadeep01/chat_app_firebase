import 'package:chatapp_firebase/screens/login_page.dart';
import 'package:chatapp_firebase/screens/signup_page.dart';
import 'package:flutter/material.dart';

class LoginAndSingup extends StatefulWidget {
  const LoginAndSingup({super.key});

  @override
  State<LoginAndSingup> createState() => _LoginAndSingupState();
}

class _LoginAndSingupState extends State<LoginAndSingup> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        ontap: togglePages,
      );
    } else {
      return SignupPage(
        ontap: togglePages,
      );
    }
  }
}
