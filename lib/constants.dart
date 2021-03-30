import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

//Hero animation tags
const kLogoTag = 'logo';

//Rounded button constants
const kLogInColour = Colors.lightBlueAccent;
const kLogInTxt = 'Log In';

const kRegisterColour = Colors.blueAccent;
const kRegisterTxt = 'Register';

const kEnterEmail = 'Enter you email';
const kEnterPassword = 'Enter your password';

const kTextFieldTextStyle = TextStyle(
    color: Color(0xFF525252)
);

const kTextfieldDecorationRegister = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  hintText: 'Enter your password.',

  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: kRegisterColour, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: kRegisterColour, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kTextfieldDecorationLogin = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  hintText: 'Enter your password.',
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: kLogInColour, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: kLogInColour, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

//constants to retrieve data from Firebase
const kMessagesCollection = 'messages';
const kSender = 'sender';
const kMessage = 'text';
const kDateSent = 'dateSent';