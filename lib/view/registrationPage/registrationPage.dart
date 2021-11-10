import 'package:flutter/material.dart';
import 'package:spinchat/view/registrationPage/registrationPageViewModel.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/utils/validations.dart';
import 'package:spinchat/widgets/custom_textfield.dart';
import 'package:spinchat/widgets/roundedButton.dart';
import 'package:stacked/stacked.dart';

class Regiistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationPageViewModel>.reactive(
      viewModelBuilder: () => RegistrationPageViewModel(),
      builder: (ctx, model, child) => Scaffold(
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/rectangle.png'),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: model.resetForm,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextField(
                          hintText: 'Username',
                          controller: model.userNameController,
                          validateFunction: Validations.validateName,
                          onChange: (val) {}),
                      SizedBox(height: 10),
                      CustomTextField(
                          hintText: 'Email',
                          controller: model.emailController,
                          validateFunction: Validations.validateEmail,
                          onChange: (val) {}),
                      SizedBox(height: 10),
                      CustomTextField(
                          validateFunction: Validations.validatePassword,
                          hintText: 'Password',
                          controller: model.passwordController,
                          onChange: (val) {}),
                      SizedBox(height: 10),
                      CustomTextField(
                          obscureText: true,
                          hintText: "Confirm Password",
                          controller: model.confirmPassword,
                          keyboardType: TextInputType.visiblePassword,
                          validateFunction: model.confirmPasswordFields,
                          onChange: (val) {}),
                      SizedBox(height: 30),
                      CustomButton(
                        label: 'Register',
                        color: AppColors.naveyBlue,
                        onTap: () async {
                          model.signUp();
                        },
                      ),
                        SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? '),
                          GestureDetector(
                            onTap: () {
                              model.navigateToLogin();
                            },
                            child: Text(
                              'Login',
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
