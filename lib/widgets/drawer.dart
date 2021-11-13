import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/app/models.dart/icon_drawer.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatView/chat_view_screen_viewmodel.dart';
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
    return  ViewModelBuilder<ChatViewModel>.reactive(viewModelBuilder: () => ChatViewModel(), builder: (ctx, model, child) => Drawer(
      child: Container(
        color: model.isWhite ? AppColors.naveyBlue : AppColors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 100, 15.0, 15.0),
          child: Column(
            children: [
            const ProfileAvatar(),
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
                        style: GoogleFonts.spinnaker(
                          color: model.isWhite
                              ? AppColors.myGreen
                              : AppColors.naveyBlue,
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
    ))  ;
  }
}
