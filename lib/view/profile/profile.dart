import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/profile/profile_viewmodel.dart';
import 'package:spinchat/widgets/profile/profile_image_avatar.dart';
import 'package:stacked/stacked.dart';

class Profile extends StatelessWidget {
  final String uid;
  final String networkUrl;
  final String username;
  final String aboutMe;
  const Profile(
      {Key? key,
      required this.networkUrl,
      required this.username,
      required this.aboutMe,
      required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onModelReady: (model) => model.isFollowing(model.userId, uid),
        builder: (ctx, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.myGreen,
              bottom: PreferredSize(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileAvatar(
                      photosUrl: networkUrl,
                    ),
                    if (model.userId == uid)
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Edit profile',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: AppColors.naveyBlue,
                          ),
                        ),
                      )
                    else if (model.userId != uid && model.isFollow == false)
                      TextButton(
                        onPressed: () {
                          model.follow(model.userId, uid);
                        },
                        child: Text(
                          'follow',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: AppColors.naveyBlue,
                          ),
                        ),
                      )
                    else if (model.userId != uid && model.isFollow == true)
                      TextButton(
                        onPressed: () {
                          model.unfollow(model.userId, uid);
                        },
                        child: Text(
                          'unfollow',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: AppColors.naveyBlue,
                          ),
                        ),
                      ),
                  ],
                ),
                preferredSize: const Size.fromHeight(150),
              ),
            ),
            body: Container(),
          );
        });
  }
}
