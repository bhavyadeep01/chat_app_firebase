import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {

  final String text;
  final void Function()? ontap;
  const UserTile({super.key,required this.text,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [

            //icon
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 15,
                child: Icon(Icons.person,color: Colors.white,)),

            SizedBox(width: 20,),
            //username
            Text(text,style: TextStyle(fontSize: 16),),

          ],
        ),
      ),
    );
  }
}
