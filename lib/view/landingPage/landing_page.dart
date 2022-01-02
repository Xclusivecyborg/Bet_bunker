import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/view/landingPage/landing_page_viewmodel.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/widgets/app_wide_widgets/rounded_button.dart';
import 'package:stacked/stacked.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandingPageViewModel>.reactive(
        viewModelBuilder: () => LandingPageViewModel(),
        onModelReady: (model) {
          model.setTheme();
        },
        builder: (context, model, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 120.0, bottom: 50),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/rectangle.png'),
                              ),
                            ),
                          ),
                          Text(
                            'BetBunker',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w900,
                              color: AppColors.mydeepGreen,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.height / 2,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/Group.png'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Share booking codes, connect with friends',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: AppColors.myDarkGrey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 80),
                      CustomButton(
                        label: 'Click to get started',
                        onTap: () {
                          model.navigateToRegistrationPage();
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
              ),
            ),
          );
        });
  }
}
