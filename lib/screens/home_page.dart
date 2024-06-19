//import 'package:chatapp_firebase/auth/auth_service.dart';
//import 'dart:js';
import 'package:chatapp_firebase/screens/chat_page.dart';
import 'package:chatapp_firebase/services/auth/auth_service.dart';
import 'package:chatapp_firebase/services/chat/chat_services.dart';
import 'package:chatapp_firebase/widgets/my_drawer.dart';
import 'package:chatapp_firebase/widgets/user_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Home',),
      ),
      drawer: MyDrawer(),
      body: buildUserList(),
    );
  }

  // build the list of users except for the current logged in user
  Widget buildUserList() {
    return StreamBuilder(
      stream: chatService.getUserStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return Text('Error');
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        // return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => buildUserListItem(userData,context))
              .toList(),
        );
      },
    );
  }

  Widget buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user

    if(userData['email'] != authService.getCurrentUser()){
      return UserTile(
          text: userData['email'],
          ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverEmail: userData['email'],
                    receiverId: userData['uid'],
                  ),
                ));
          });
    }
    else{
      return Container();
    }
  }
}
