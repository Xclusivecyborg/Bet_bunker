// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/view/registrationPage/registration_page_viewmodel.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/utils/validations.dart';
import 'package:spinchat/widgets/app_wide_widgets/custom_textfield.dart';
import 'package:spinchat/widgets/app_wide_widgets/rounded_button.dart';
import 'package:stacked/stacked.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationPageViewModel>.reactive(
      viewModelBuilder: () => RegistrationPageViewModel(),
      builder: (ctx, model, child) => Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    CupertinoIcons.arrow_left,
                    color: AppColors.black,
                    size: 40,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Let's start here",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    fontSize: 34,
                  ),
                ),
                Text(
                  "Fill in your details to begin",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: AppColors.myDarkGrey,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                              const SizedBox(height: 10),
                              CustomTextField(
                                  hintText: 'Email',
                                  controller: model.emailController,
                                  validateFunction: Validations.validateEmail,
                                  onChange: (val) {}),
                              const SizedBox(height: 10),
                              CustomTextField(
                                  validateFunction:
                                      Validations.validatePassword,
                                  hintText: 'Password',
                                  controller: model.passwordController,
                                  onChange: (val) {}),
                              const SizedBox(height: 10),
                              CustomTextField(
                                  obscureText: true,
                                  hintText: "Confirm Password",
                                  controller: model.confirmPassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  validateFunction: model.confirmPasswordFields,
                                  onChange: (val) {}),
                              const SizedBox(height: 30),
                              CustomButton(
                                width: double.infinity,
                                label: 'Register',
                                onTap: () async {
                                  model.signUp();
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account? ',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.myDarkGrey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      model.navigateToLogin();
                                    },
                                    child: Text(
                                      'Login',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.myRed,
                                        fontSize: 15,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
