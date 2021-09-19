import 'package:flutter/material.dart';

const myGreen = Color(0xFF4CA772);
const myLightGreen = Color(0xFF9CCC65);
const myOrange = Color(0xFFFFB425);
const myDarkGrey = Color(0xFF565656);
const kMyMediumGrey = Color(0xFF7E7E7E);
const myLightGrey = Color(0xFFC4C4C4);
const KMyWhite = Colors.white;
const kMyBlack = Color(0xFF000000);
const kMyRed = Color(0xFFDD5408);
const myLightBlue = Color(0xFF949AEE);
const kMyBlue = Colors.blueAccent;
const Color kMynaveyBlue = Color(0XFF162337);
const Color KmyGreen = Color(0xff42CB91);
const Color mydeepGreen = Color(0xFF0E5357);
const Color kMylightBlue = Colors.lightBlueAccent;

const kBorderStyle = UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.transparent),
);

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

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.blueAccent,
  ),
  hintText: 'Enter value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
