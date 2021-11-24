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
      onModelReady: (model) => model.initialise(),
      viewModelBuilder: () => ChatViewModel(),
      builder: (ctx, model, child) => Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          title: CustomTextField(
            focusNode: model.searchFocus,
            autofocus: false,
            hintText: 'Search in chat',
            controller: model.searchResults,
            height: 40,
            bordercolor: Colors.white12,
            onChange: model.onSearchUsername,
          ),
          actions: [
            IconButton(
              onPressed: model.getUsersByUsername,
              icon: const Icon(Icons.search, color: AppColors.naveyBlue),
            ),
          ],
        ),
        body: model.matchingUsernames.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: model.searchFocus.hasFocus ? false : true,
                      child: const CircularProgressIndicator(),
                    ),
                    model.searchFocus.hasFocus
                        ? const Text('NO DATA')
                        : Container()
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SingleChildScrollView(
                  child: ListView.separated(
                    reverse: true,
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 2,
                    ),
                    shrinkWrap: true,
                    itemCount: model.matchingUsernames.length,
                    itemBuilder: (context, index) => CustomTile(
                      leading: LeadingAvatar(
                        photo: model.matchingUsernames[index].photoUrl!,
                      ),
                      isUserLoggedIn: model.userStatus,
                      isWhite: true,
                      chatPage: false,
                      username: model.matchingUsernames[index].userName,
                      ontap: () {
                        model.naviagteToChatScreen(
                          isUserOnline:
                              model.matchingUsernames[index].loggedIn!,
                          user: model.matchingUsernames[index].userName!,
                          networkLink: model.matchingUsernames[index].photoUrl!,
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
