import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextEditingController mController;
  const MyTextField({super.key,
    required this.hintText,
    required this.obscureText,
    required this.mController,
    this.focusNode,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 8),
      child: TextField(
            controller: mController,
            obscureText: obscureText,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.go,
            focusNode: focusNode,
            decoration: InputDecoration(
                hintText: hintText,
                //suffixIcon: Icon(Icons.mail,),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(color: Colors.black),
                ),
                fillColor: Colors.grey.shade200,
                filled: true),

      ),
    );
  }
}
