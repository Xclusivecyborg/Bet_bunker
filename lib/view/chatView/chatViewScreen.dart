import 'package:flutter/material.dart';
import 'package:spinchat/app/models.dart/icon_drawer.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatView/chatViewScreen_viewModel.dart';
import 'package:spinchat/view/searchScreen/searchScreen.dart';
import 'package:spinchat/widgets/custom_tile.dart';
import 'package:spinchat/widgets/drawer.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class ChatView extends StatelessWidget {
  final String username;
  ChatView({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
        onModelReady: (model) => model.initialise(),
        viewModelBuilder: () => ChatViewModel(),
        builder: (context, model, child) {
          List<IconDrawer> listChoices = [
            IconDrawer(
                title: 'Theme',
                icon: Switch(
                    value: model.isWhite,
                    onChanged: (val) {
                      model.toggleTheme(val);
                    }),
                onpressed: () {}),
            IconDrawer(
                title: 'Settings',
                icon: Icon(
                  Icons.settings,
                  color:
                      model.isWhite ? AppColors.myGreen : AppColors.naveyBlue,
                ),
                onpressed: () {
                  model.navigateToSettings();
                }),
          ];
          return Scaffold(
            backgroundColor:
                model.isWhite ? AppColors.naveyBlue : AppColors.white,
            key: scaffoldKey,
            drawer: AppDrawer(listChoices: listChoices),
            appBar: AppBar(
              backgroundColor:
                  model.isWhite ? AppColors.naveyBlue : AppColors.white,
              leading: GestureDetector(
                onTap: () => scaffoldKey.currentState!.openDrawer(),
                child: Icon(
                  Icons.menu,
                  color:
                      model.isWhite ? AppColors.myGreen : AppColors.naveyBlue,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.search, color: AppColors.naveyBlue),
                ),
                IconButton(
                  onPressed: () {
                    model.logout();
                  },
                  icon: Icon(Icons.logout, color: AppColors.naveyBlue),
                ),
              ],
              elevation: 1,
              title: Text(
                'SpinChat',
                style: GoogleFonts.spinnaker(
                  color:
                      model.isWhite ? AppColors.myGreen : AppColors.naveyBlue,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.naveyBlue,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              child: Icon(Icons.message),
            ),
            body: model.snapshot == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: [
                        ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            thickness: 2,
                          ),
                          shrinkWrap: true,
                          itemCount: model.snapshot!.length,
                          itemBuilder: (context, index) => CustomTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                '${model.snapshot![index].data()['photoUrl']}',
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                                errorBuilder: (ctx, object, stackTrace) {
                                  return Icon(
                                    Icons.account_circle,
                                    size: 40,
                                    color: AppColors.myDarkGrey,
                                  );
                                },
                                loadingBuilder: (ctx, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Container(
                                      height: 30,
                                      width: 30,
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
                            isWhite: model.userStatus!,
                            chatPage: true,
                            isUserLoggedIn:
                                model.snapshot![index].data()['loggedIn'],
                            username:
                                model.snapshot![index].data()['userName'] ??
                                    'No data',
                            ontap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
