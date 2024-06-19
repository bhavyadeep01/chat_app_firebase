import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? ontap;
  final String text;
  const MyButton({super.key,required this.text,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 8),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Colors.black,
          ),
          child: Center(
            child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),
          ),
        ),
      ),
    );
  }
}
