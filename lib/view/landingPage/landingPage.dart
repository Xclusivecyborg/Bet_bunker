import 'package:flutter/material.dart';
import 'package:spinchat/view/landingPage/landingPageViewModel.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/widgets/roundedButton.dart';
import 'package:stacked/stacked.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandingPageViewModel>.reactive(
        viewModelBuilder: () => LandingPageViewModel(),
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
                        label: 'Click to get started',
                        onTap: () {
                          model.navigateToRegistrationPage();
                        },
                        color: AppColors.naveyBlue,
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
              ),
            ),
          );
        });
  }
}
