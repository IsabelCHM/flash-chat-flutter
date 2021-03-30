import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = '/chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final textEditingController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageTxt;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }
  // void getMessages() async {
  //   final messages = await _firestore.collection(kMessagesCollection).get();
  //   for (var message in messages.docs)
  //     {
  //       print(message.data());
  //     }
  // }

  void messagesStream() async {
    await for (var snapshot
        in _firestore.collection(kMessagesCollection).snapshots()) {
      for (var message in snapshot.docs) {
        //functionality when new message is retrieved here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      style: kTextFieldTextStyle,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageTxt = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection(kMessagesCollection).add(
                          {kMessage: messageTxt,
                            kSender: loggedInUser.email,
                          kDateSent: DateTime.now()});
                      textEditingController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection(kMessagesCollection).orderBy(kDateSent).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: kLogInColour,
              ),
            );
          }

          final messages = snapshot.data.docs;
          List<Widget> MsgTxts = [];
          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];
            final currentUserEmail = loggedInUser.email;
            Widget newText = MessageBubble(messageText, messageSender, currentUserEmail == messageSender);
            MsgTxts.add(newText);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: MsgTxts,
            ),
          );
        });
  }
}


class MessageBubble extends StatelessWidget {
  final String messageText;
  final String messageSender;
  final bool isMe;

  MessageBubble(this.messageText, this.messageSender, this.isMe);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: isMe ? EdgeInsets.only(right: 5) : EdgeInsets.only(left: 5),
            child: Text(messageSender,
            style: TextStyle(
              fontSize: 12
            ),),
          ),
          SizedBox(height: 3,),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color: isMe ? kLogInColour : kRegisterColour,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(messageText,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
