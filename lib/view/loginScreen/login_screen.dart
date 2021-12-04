import 'package:flutter/material.dart';
import 'package:spinchat/view/loginScreen/login_screen_viewmodel.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/utils/validations.dart';
import 'package:spinchat/widgets/app_wide_widgets/custom_textfield.dart';
import 'package:spinchat/widgets/app_wide_widgets/rounded_button.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginScreenViewModel>.reactive(
      viewModelBuilder: () => LoginScreenViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 150, 25, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/rectangle.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: model.resetForm,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextField(
                        onChange: (val) {},
                        hintText: 'Email',
                        controller: model.newEmailController,
                        validateFunction: Validations.validateEmail,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                          onChange: (val) {},
                          obscureText: true,
                          validateFunction: Validations.validatePassword,
                          hintText: 'Password',
                          controller: model.newPasswordController),
                      const SizedBox(height: 30),
                      CustomButton(
                        label: 'Login',
                        color: AppColors.naveyBlue,
                        onTap: () async {
                          await model.login();
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Not signed up yet?, click here to '),
                          GestureDetector(
                            onTap: () {
                              model.navigateToRegistrationPage();
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.myRed,
                              ),
                            ),
                          ),
                        ],
                      )
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
