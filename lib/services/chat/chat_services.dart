import 'package:chatapp_firebase/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverId, message) async {
    //get current user info
    final String currentUserid = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        senderId: currentUserid,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    //construct chat room id for the two user
    List<String> ids = [currentUserid, receiverId];
    ids.sort();
    String chatroomId = ids.join("_");

    //add new message to database
    await firestore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

//get messages
  Stream<QuerySnapshot> getMessages(String userId, otheruserId) {
//construct a chatroom id for two users
    List<String> ids = [userId, otheruserId];
    ids.sort();
    String chstroomId = ids.join("_");
    return firestore
        .collection("chat_rooms")
        .doc(chstroomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
