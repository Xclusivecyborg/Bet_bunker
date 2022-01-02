import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatView/chat_view_screen_viewmodel.dart';
import 'package:spinchat/widgets/profile/profile_image_avatar.dart';
import 'package:spinchat/widgets/app_wide_widgets/rounded_button.dart';
import 'package:stacked/stacked.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            title: const Text('Settings',
                style: TextStyle(color: AppColors.black)),
            backgroundColor: AppColors.white,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          builder: (_) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 100.0,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'Choose Profile Photo',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton.icon(
                                      label: const Text('Camera'),
                                      onPressed: () async {
                                        await model
                                            .pickImage(ImageSource.camera);
                                        model.popNavigation();
                                      },
                                      icon: const Icon(
                                        Icons.camera,
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      label: const Text('Gallery'),
                                      onPressed: () async {
                                        await model
                                            .pickImage(ImageSource.gallery);
                                        model.popNavigation();
                                      },
                                      icon: const Icon(
                                        Icons.image,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: ProfileAvatar(
                        photosUrl: model.myphotoUrl!,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 10, top: 30, bottom: 5),
                          child: const Text('username'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: AppColors.myGreen,
                            ),
                            child: TextField(
                              controller: model.username,
                              onChanged: (val) {
                                // model.onchanged(val);
                              },
                              decoration: const InputDecoration(
                                hintText: 'Write your name',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.myDarkGrey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.myGreen),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 10, top: 30, bottom: 5),
                          child: const Text('About me'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: AppColors.myGreen,
                            ),
                            child: TextField(
                              controller: model.aboutMe,
                              onChanged: (val) {},
                              decoration: const InputDecoration(
                                hintText: 'Write something about yourself',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.myDarkGrey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.myGreen),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: CustomButton(
                            label: 'Update',
                            onTap: () {
                              model.updateDetails();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
