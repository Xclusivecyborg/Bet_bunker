import 'package:flutter/material.dart';
import 'package:spinchat/Screens/chatscreen/chatScreen.dart';
import 'package:spinchat/services/authService.dart';
import 'package:spinchat/utils/constants.dart';
import 'package:spinchat/utils/validations.dart';
import 'package:spinchat/widgets/alertDialog.dart';
import 'package:spinchat/widgets/custom_textfield.dart';
import 'package:spinchat/widgets/roundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Regiistration extends StatefulWidget {
  static final String id = 'registration';
  const Regiistration({Key? key}) : super(key: key);

  @override
  _RegiistrationState createState() => _RegiistrationState();
}

class _RegiistrationState extends State<Regiistration> {
  AuthService _auth = AuthService();
  GlobalKey<FormState> _resetForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMyWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 150, 25, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Form(
                key: _resetForm,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Email',
                      controller: emailController,
                      validateFunction: Validations.validateEmail,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      validateFunction: Validations.validatePassword,
                      hintText: 'Password',
                      controller: passwordController,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      obscureText: true,
                      hintText: "Confirm Password",
                      controller: confirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      validateFunction: (String? value) {
                        if (passwordController.text != confirmPassword.text) {
                          return 'Passwords do not match!.';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      label: 'Register',
                      color: kMynaveyBlue,
                      onTap: () async {
                        if (_resetForm.currentState!.validate()) {
                          final registeredUSer = await _auth.signUp(
                              emailController.text, passwordController.text);
                          if (registeredUSer != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(),
                              ),
                            );
                          }
                        } else {
                          return showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertWidget(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
