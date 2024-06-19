import 'package:chatapp_firebase/services/auth/auth_service.dart';
import 'package:chatapp_firebase/services/chat/chat_services.dart';
import 'package:chatapp_firebase/widgets/chat_bubble.dart';
import 'package:chatapp_firebase/widgets/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;

  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();

  final ChatService chatService = ChatService();

  final AuthService authService = AuthService();

  //text field focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //listener
    myFocusNode.addListener(() {
      if(myFocusNode.hasFocus){
        Future.delayed(Duration(microseconds: 500),()=> ScrollDown(),);
      }
    });
    //waits for list view to be build then scroll
    Future.delayed(Duration(microseconds: 500),()=> ScrollDown());
  }
 @override
  void dispose() {
    myFocusNode.dispose();
    messageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  //scroll controller
  final ScrollController scrollController = ScrollController();
  void ScrollDown(){
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }
  //send message
  void sendMessage() async {
    //if there is something inside the text field
    if (messageController.text.isNotEmpty) {
      //send message
      await chatService.sendMessage(widget.receiverId, messageController.text);

      //clear the controller
      messageController.clear();
    }
    ScrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.receiverEmail,),
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child: buildMessageList()),
          //user input
          buildUserInput(),
        ],
      ),
    );
  }

  //build message list
  Widget buildMessageList() {
    String senderId = authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatService.getMessages(widget.receiverId, senderId),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return Text("Error");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          //return list view
          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList(),
          );
        });
  }

  // build message list
  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['senderId'] == authService.getCurrentUser()!.uid;

    //align messages to left if sender is the current user otherwise left
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      height: double.infinity,
        alignment: alignment,
        color: Colors.indigo,
        child: Expanded(
          child: Column(
            // mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              ChatBubble(message: data['message'], isCurrentUser: isCurrentUser,),
            ],
          ),
        ));
  }

  //build message input
  Widget buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              focusNode: myFocusNode,
              mController: messageController,
              hintText: 'Type a message',
              obscureText: false,
            ),
          ),

          //send button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black,
                child: IconButton(onPressed: sendMessage, icon: Icon(Icons.send,color: Colors.white,))),
          )
        ],
      ),
    );
  }
}
