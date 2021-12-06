import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/app/models.dart/icon_drawer.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/homescreen/home_screen_viewmodel.dart';
import 'package:spinchat/widgets/profile/profile_image_avatar.dart';
import 'package:stacked/stacked.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
    required this.listChoices,
  }) : super(key: key);

  final List<IconDrawer> listChoices;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
        viewModelBuilder: () => HomeScreenViewModel(),
        builder: (ctx, model, child) => Drawer(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.myGreen,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 100, 15.0, 45.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              model.navigateToProfile(
                                id: model.userId!,
                                bio: model.myBio!,
                                photo: model.myPhoto!,
                                username: model.myUsername!,
                              );
                            },
                            child: ProfileAvatar(
                              photosUrl: model.myPhoto ?? '',
                            ),
                          ),
                          Text(
                            'Hey!👋🏽 ${model.myUsername ?? ''}',
                            style: GoogleFonts.poppins(
                              color: model.isWhite
                                  ? AppColors.myGreen
                                  : AppColors.naveyBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: listChoices.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) => InkWell(
                          onTap: listChoices[index].onpressed,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                listChoices[index].title,
                                style: GoogleFonts.poppins(
                                  color: model.isWhite
                                      ? AppColors.myGreen
                                      : AppColors.naveyBlue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              listChoices[index].icon,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
