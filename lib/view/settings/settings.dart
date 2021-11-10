import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatView/chatViewScreen_viewModel.dart';
import 'package:spinchat/widgets/profile/profile_image_avatar.dart';
import 'package:spinchat/widgets/roundedButton.dart';
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
            title: Text('Settings', style: TextStyle(color: AppColors.black)),
            backgroundColor:
                model.isWhite ? AppColors.naveyBlue : AppColors.white,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          builder: (_) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 100.0,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  'Choose Profile Photo',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton.icon(
                                      label: Text('Camera'),
                                      onPressed: () async {
                                        await model
                                            .pickImage(ImageSource.camera);
                                      },
                                      icon: Icon(
                                        Icons.camera,
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      label: Text('Gallery'),
                                      onPressed: () async {
                                        await model
                                            .pickImage(ImageSource.gallery);
                                      },
                                      icon: Icon(
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
                      child: ProfileAvatar(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 30, bottom: 5),
                          child: Text('username'),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: AppColors.myGreen,
                            ),
                            child: TextField(
                              controller: model.username,
                              onChanged: (val) {
                                // model.onchanged(val);
                              },
                              decoration: InputDecoration(
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
                          margin: EdgeInsets.only(left: 10, top: 30, bottom: 5),
                          child: Text('About me'),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: AppColors.myGreen,
                            ),
                            child: TextField(
                              controller: model.aboutMe,
                              onChanged: (val) {},
                              decoration: InputDecoration(
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
                        SizedBox(height: 30),
                        Center(
                          child: CustomButton(
                            label: 'Update',
                            color: AppColors.naveyBlue,
                            onTap: () {
                              // model.updateDetails();
                              print(model.photosUrl);
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
