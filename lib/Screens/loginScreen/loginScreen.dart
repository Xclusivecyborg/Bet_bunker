import 'package:flutter/material.dart';
import 'package:spinchat/Screens/chatView/chatViewScreen.dart';
// import 'package:spinchat/Screens/chatscreen/chatScreen.dart';
import 'package:spinchat/Screens/loginScreen/loginScreenViewModel.dart';
import 'package:spinchat/services/authService.dart';
import 'package:spinchat/utils/constants.dart';
import 'package:spinchat/utils/validations.dart';
import 'package:spinchat/widgets/alertDialog.dart';
import 'package:spinchat/widgets/custom_textfield.dart';
import 'package:spinchat/widgets/roundedButton.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatefulWidget {
  static final String id = "loginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = true;
  AuthService _auth = AuthService();
  GlobalKey<FormState> _resetForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginScreenViewModel>.reactive(
      viewModelBuilder: () => LoginScreenViewModel(),
      builder: (context, model, child) => Scaffold(
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
                        obscureText: true,
                        validateFunction: Validations.validatePassword,
                        hintText: 'Password',
                        controller: passwordController,
                      ),
                      SizedBox(height: 30),
                      CustomButton(
                        label: 'Login',
                        color: kMynaveyBlue,
                        onTap: () async {
                          if (_resetForm.currentState!.validate()) {
                            if (isLoading == true) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return LoadingDialog();
                                },
                              );
                            }
                            final createdUser = await _auth.login(
                                emailController.text, passwordController.text);
                            print('${model.loggedInUSer!.uid}');

                            if (createdUser != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatView(),
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
      ),
    );
  }
}
