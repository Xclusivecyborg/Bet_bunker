import 'package:flutter/material.dart';
import 'package:spinchat/view/chatView/chat_view_screen_viewmodel.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/widgets/custom_textfield.dart';
import 'package:spinchat/widgets/custom_tile.dart';
import 'package:stacked/stacked.dart';

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
              model.getUsers(val: val);
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
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 2,
                  ),
                  shrinkWrap: true,
                  itemCount: model.snapshot!.length,
                  itemBuilder: (context, index) => CustomTile(
                    leading: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  '${ model.snapshot![index].data()['photoUrl']}',
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                  errorBuilder: (ctx, object, stackTrace) {
                    return const Icon(
                      Icons.account_circle,
                      size: 40,
                      color: AppColors.myDarkGrey,
                    );
                  },
                  loadingBuilder:
                      (ctx, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return SizedBox(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: CircularProgressIndicator(
                              value: loadingProgress
                                          .expectedTotalBytes !=
                                      null
                                  ? loadingProgress
                                          .cumulativeBytesLoaded /
                                      loadingProgress
                                          .expectedTotalBytes!
                                  : null),
                        ),
                      );
                    }
                  },
                ),
              ),
                    isUserLoggedIn: model.userStatus,
                    isWhite: model.isWhite,
                    chatPage: false,
                    username: model.snapshot![index].data()['userName'],
                    ontap: () {
                      // ignore: unused_element
                      startConversation(String username) {
                        // List<String> users = [
                        //   username,
                        // ];
                        // model.chatRoomCreate(chatRoomId, data)
                      }
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
