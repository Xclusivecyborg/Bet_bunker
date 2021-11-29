import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/app/models.dart/icon_drawer.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatView/chat_view_search_screen.dart';
import 'package:spinchat/widgets/drawer.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        List<IconDrawer> listChoices = [
          IconDrawer(
              title: 'Theme',
              icon: Switch(
                  value: model.isWhite,
                  onChanged: (val) {
                    model.toggleTheme(val);
                  }),
              onpressed: () {
                (val) {
                  model.toggleTheme(val);
                };
              }),
          IconDrawer(
              title: 'Settings',
              icon: Icon(
                Icons.settings,
                color: model.isWhite ? AppColors.myGreen : AppColors.naveyBlue,
              ),
              onpressed: () {
                model.navigateToSettings();
              }),
        ];
        return Scaffold(
          key: scaffoldKey,
          drawer: AppDrawer(listChoices: listChoices),
          appBar: AppBar(
            backgroundColor: AppColors.white,
            leading: GestureDetector(
              onTap: () => scaffoldKey.currentState!.openDrawer(),
              child: const Icon(
                Icons.menu,
                color: AppColors.naveyBlue,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search, color: AppColors.naveyBlue),
              ),
              IconButton(
                onPressed: () {
                  model.logout();
                },
                icon: const Icon(Icons.logout, color: AppColors.naveyBlue),
              ),
            ],
            elevation: 1,
            title: Text(
              'BetBunk',
              style: GoogleFonts.poppins(
                color: AppColors.naveyBlue,
              ),
            ),
          ),
          body: ListOfPosts(
            model: model,
          ),
        );
      },
    );
  }
}

class ListOfPosts extends StatelessWidget {
  final HomeScreenViewModel model;
  const ListOfPosts({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      separatorBuilder: (_, index) => const SizedBox(),
      itemCount: 15,
      itemBuilder: (_, index) => SizedBox(
        height: MediaQuery.of(context).size.height / 2.2,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // model.navigateToProfile();
                      },
                      child: Container(
                        height: 40,
                        width: 50,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.myYellow,
                              AppColors.myRed,
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        // child: LeadingAvatar(photo: networkImage),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Xclusivecyborg',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: AppColors.myGreen,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.heart,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.bubble_right,
                    size: 32,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.arrowshape_turn_up_right,
                    size: 32,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
