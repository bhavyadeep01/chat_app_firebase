//import 'package:chatapp_firebase/auth/auth_service.dart';
import 'package:chatapp_firebase/screens/settings_page.dart';
import 'package:chatapp_firebase/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(child: Icon(Icons.chat,size: 40,color: Colors.black,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              leading: Icon(Icons.home,color: Colors.black,),
              title: Text('HOME',style: TextStyle(color: Colors.black),),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              leading: Icon(Icons.settings,color: Colors.black,),
              title: Text('SETTINGS',style: TextStyle(color: Colors.black),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              leading: Icon(Icons.logout,color: Colors.black,),
              title: Text('LOGOUT',style: TextStyle(color: Colors.black),),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
