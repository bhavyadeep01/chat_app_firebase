//import 'package:chatapp_firebase/auth/auth_service.dart';
import 'package:chatapp_firebase/services/auth/auth_service.dart';
import 'package:chatapp_firebase/widgets/my_elevatedbutton.dart';
import 'package:chatapp_firebase/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emaiController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final void Function()? ontap;

  LoginPage({super.key, required this.ontap});

  void login(BuildContext context) {
    final authService = AuthService();

    try {
      authService.signInWithEmailPassword(
          emaiController.text, pwController.text);
    } catch (ex) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(ex.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat,
              size: 60,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                //color: Theme.of(context).colorScheme.primary),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MyTextField(
              hintText: 'Email',
              obscureText: false,
              mController: emaiController,
            ),
            MyTextField(
              hintText: 'Password',
              obscureText: true,
              mController: pwController,
            ),
            SizedBox(
              height: 5,
            ),
            MyButton(text: 'Login', ontap: () => login(context)),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not have an account? ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                GestureDetector(
                  onTap: ontap,
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
