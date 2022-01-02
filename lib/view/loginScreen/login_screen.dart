import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      color: AppColors.black,
                      size: 40,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  Text(
                    "Hey! welcome back",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                      fontSize: 34,
                    ),
                  ),
                  Text(
                    "login below",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: AppColors.myDarkGrey,
                      fontSize: 17,
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
                          width: double.infinity,
                          onTap: () async {
                            await model.login();
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not signed up yet?, click here to ',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: AppColors.myDarkGrey,
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                model.navigateToRegistrationPage();
                              },
                              child: Text(
                                'Register',
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
        ),
      ),
    );
  }
}
