import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/widgets/custom_textfield.dart';
import 'package:spinchat/widgets/custom_tile.dart';

import 'package:spinchat/widgets/profile/users_circle_avatar.dart';
import 'package:stacked/stacked.dart';

import 'chat_view_screen_viewmodel.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(),
      builder: (ctx, model, child) => Scaffold(
        backgroundColor: model.isWhite ? AppColors.naveyBlue : AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:
              model.isWhite ? AppColors.naveyBlue : AppColors.white,
          title: CustomTextField(
            autofocus: true,
            hintText: 'Search in chat',
            controller: model.searchResults,
            height: 40,
            bordercolor: Colors.white12,
            onChange: (val) {
              model.getUsersByUsername(val: val);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                model.getUSersForOnchangedFunction();
              },
              icon: const Icon(Icons.search, color: AppColors.naveyBlue),
            ),
          ],
        ),
        body: model.snapshot == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SingleChildScrollView(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 2,
                    ),
                    shrinkWrap: true,
                    itemCount: model.snapshot!.length,
                    itemBuilder: (context, index) => CustomTile(
                      leading: LeadingAvatar(
                        photo: model.snapshot![index].data()['photoUrl'],
                      ),
                      isUserLoggedIn: model.userStatus,
                      isWhite: model.isWhite,
                      chatPage: false,
                      username: model.snapshot![index].data()['userName'],
                      ontap: () {
                        model.naviagteToChatScreen(
                            isUserOnline:
                                model.snapshot![index].data()['loggedIn'],
                            user: model.snapshot![index].data()['userName'],
                            networkLink:
                                model.snapshot![index].data()['photoUrl'],
                                );
                      },
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
