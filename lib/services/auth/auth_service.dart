import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore =FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  // sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      //save user info if it already exists
      firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid, 'email': email,
          }
      );
      return userCredential;
    } on FirebaseAuthException catch (ex) {
      throw Exception(ex.code);
    }
  }

  //sign up
  Future<UserCredential> signupWithEmailAndPassword(
      String email, password) async {
    try {
      //create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      
      firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid, 'email': email,
          }
      );
      return userCredential;
    } on FirebaseAuthException catch (ex) {
      throw Exception(ex.code);
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
