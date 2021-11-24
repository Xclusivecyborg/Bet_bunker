import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatView/chat_view_screen_viewmodel.dart';
import 'package:spinchat/widgets/custom_search_field.dart';
import 'package:spinchat/widgets/custom_tile.dart';
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
            backgroundColor:
                model.isWhite ? AppColors.naveyBlue : AppColors.white,
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
                            color: AppColors.black,
                            fontSize: 34,
                          ),
                        ),
                        CustomSearchField(
                          controller: model.searchFieldController,
                          onChanged: model.onSearchUser,
                          preixIcon: Icons.search,
                          hint: 'search',
                          // suffixIcon: Padding(
                          //   padding: const EdgeInsets.only(top: 5.0),
                          //   child: Image.asset(
                          //     'assets/Filter.png',
                          //   ),
                          // ),
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
                            itemBuilder: (context, index) => CustomTile(
                              leading: LeadingAvatar(
                                photo: model.matchingUsers.isNotEmpty
                                    ? model.matchingUsers[index].photoUrl!
                                    : model.usersnapshot[index].photoUrl!,
                              ),
                              isWhite: model.userStatus!,
                              chatPage: true,
                              isUserLoggedIn: model.matchingUsers.isNotEmpty
                                  ? model.matchingUsers[index].loggedIn
                                  : model.usersnapshot[index].loggedIn,
                              username: model.matchingUsers.isNotEmpty
                                  ? model.matchingUsers[index].userName
                                  : model.usersnapshot[index].userName ??
                                      'No data',
                              ontap: () {
                                model.naviagteToChatScreen(
                                  isUserOnline: model.matchingUsers.isNotEmpty
                                      ? model.matchingUsers[index].loggedIn!
                                      : model.usersnapshot[index].loggedIn!,
                                  user: model.matchingUsers.isNotEmpty
                                      ? model.matchingUsers[index].userName!
                                      : model.usersnapshot[index].userName ??
                                          'No data',
                                  networkLink: model.matchingUsers.isNotEmpty
                                      ? model.matchingUsers[index].photoUrl!
                                      : model.usersnapshot[index].photoUrl!,
                                );
                                model.searchFieldController.clearComposing();
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }
}
