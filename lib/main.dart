import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/Screens/chatscreen/chatScreen.dart';
import 'package:spinchat/Screens/landingPage/landingPage.dart';
import 'package:spinchat/Screens/loginScreen/loginScreen.dart';
import 'package:spinchat/Screens/registrationPage/registrationPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LandingPage.id,
      routes: {
        LandingPage.id: (_) => LandingPage(),
        ChatScreen.id: (_) => ChatScreen(),
        LoginScreen.id: (_) => LoginScreen(),
        Regiistration.id: (_) => Regiistration(),
      },
    );
  }
}
