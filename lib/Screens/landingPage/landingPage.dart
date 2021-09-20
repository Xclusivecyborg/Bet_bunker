import 'package:flutter/material.dart';
import 'package:spinchat/Screens/loginScreen/loginScreen.dart';
import 'package:spinchat/Screens/registrationPage/registrationPage.dart';
import 'package:spinchat/utils/constants.dart';
import 'package:spinchat/widgets/roundedButton.dart';

class LandingPage extends StatefulWidget {
  static final String id = 'landingPage';
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 120.0, bottom: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/rectangle.png'),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/Group.png'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('Connect With Friends, Family and more'),
                SizedBox(height: 80),
                CustomButton(
                  label: 'Register',
                  onTap: () {
                    Navigator.pushNamed(context, Regiistration.id);
                  },
                  color: kMynaveyBlue,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? '),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text('Login', style: TextStyle(fontSize: 25))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
