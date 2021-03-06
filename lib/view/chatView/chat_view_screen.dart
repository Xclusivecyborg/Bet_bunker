import 'package:flutter/material.dart';
import 'package:spinchat/view/chatView/chat_view_screen_viewmodel.dart';
import 'package:spinchat/widgets/chat/custom_search_field.dart';
import 'package:spinchat/widgets/app_wide_widgets/custom_tile.dart';
import 'package:spinchat/widgets/profile/users_circle_avatar.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
        onModelReady: (model) => model.initialise(),
        viewModelBuilder: () => ChatViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chat",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 34,
                          ),
                        ),
                        CustomSearchField(
                          controller: model.searchFieldController,
                          onChanged: model.onSearchUser,
                          preixIcon: Icons.search,
                          hint: 'search',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Image.asset(
                              'assets/Filter.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  model.usersnapshot.isEmpty
                      ? Center(
                          child: Container(),
                        )
                      : Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                              thickness: 1,
                            ),
                            shrinkWrap: true,
                            itemCount: model.matchingUsers.isNotEmpty
                                ? model.matchingUsers.length
                                : model.usersnapshot.length,
                            itemBuilder: (context, __) {
                              // var match = model.matchingUsers[index];
                              var user = model.usersnapshot[__];
                              return CustomTile(
                                leading: LeadingAvatar(
                                  photo: model.matchingUsers.isNotEmpty
                                      ? model.matchingUsers[__].photoUrl!
                                      : user.photoUrl!,
                                ),
                                isWhite: model.userStatus!,
                                chatPage: true,
                                isUserLoggedIn: model.matchingUsers.isNotEmpty
                                    ? model.matchingUsers[__].loggedIn
                                    : user.loggedIn,
                                username: model.matchingUsers.isNotEmpty
                                    ? model.matchingUsers[__].userName
                                    : user.userName ?? 'No data',
                                ontap: () {
                                  model.naviagteToChatScreen(
                                    uid: user.userId!,
                                    about: model.matchingUsers.isNotEmpty
                                        ? model.matchingUsers[__].aboutMe!
                                        : user.aboutMe!,
                                    isUserOnline: model.matchingUsers.isNotEmpty
                                        ? model.matchingUsers[__].loggedIn!
                                        : user.loggedIn!,
                                    user: model.matchingUsers.isNotEmpty
                                        ? model.matchingUsers[__].userName!
                                        : user.userName ?? 'No data',
                                    networkLink: model.matchingUsers.isNotEmpty
                                        ? model.matchingUsers[__].photoUrl!
                                        : user.photoUrl!,
                                  );
                                  model.searchFieldController.clearComposing();
                                },
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }
}
