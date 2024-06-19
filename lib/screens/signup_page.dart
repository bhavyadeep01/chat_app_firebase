//import 'package:chatapp_firebase/auth/auth_service.dart';
import 'package:chatapp_firebase/services/auth/auth_service.dart';
import 'package:chatapp_firebase/widgets/my_elevatedbutton.dart';
import 'package:chatapp_firebase/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController ConfirmpwController = TextEditingController();

  final void Function()? ontap;

  SignupPage({super.key, required this.ontap,});

  void signup(BuildContext context) {
   final authService = AuthService();
   if(pwController.text == ConfirmpwController.text){
     try{
       authService.signupWithEmailAndPassword(emailController.text, pwController.text,);
     }
     catch (ex){
       showDialog(
           context: context,
           builder: (context) => AlertDialog(
             title: Text(ex.toString()),
           ));
     }
   }
   else{
     showDialog(
         context: context,
         builder: (context) => AlertDialog(
           title: Text("Passwords don't match!!"),
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
              "Let's create a New Account",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MyTextField(hintText: 'Email', obscureText: false, mController: emailController),
            MyTextField(hintText: 'Password', obscureText: true, mController: pwController),
            MyTextField(hintText: 'Confirm Password', obscureText: true, mController: ConfirmpwController),
            SizedBox(
              height: 5,
            ),
            MyButton(text: 'Sign Up', ontap: () => signup(context)),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                GestureDetector(
                  onTap: ontap,
                  child: Text(
                    'Login',
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