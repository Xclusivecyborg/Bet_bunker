import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/app/models.dart/icon_drawer.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatView/chat_view_search_screen.dart';
import 'package:spinchat/widgets/drawer.dart';
import 'package:spinchat/widgets/profile/users_circle_avatar.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
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
              'BetBunker',
              style: GoogleFonts.poppins(
                color: AppColors.naveyBlue,
              ),
            ),
          ),
          body: model.isbusy
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: model.initialise,
                  color: AppColors.myGreen,
                  child: ListOfPosts(
                    model: model,
                  ),
                ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: AppColors.myGreen,
                onPressed: () {
                  model.navigateToPost();
                },
                child: const Icon(
                  CupertinoIcons.pen,
                ),
              ),
              Text(
                'Post',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: AppColors.myGreen,
                  fontSize: 16,
                ),
              ),
            ],
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
  Widget build(
    BuildContext context,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      separatorBuilder: (_, index) => const Divider(),
      itemCount: model.posts.length,
      itemBuilder: (_, index) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (model.users.length < model.posts.length)
                        const SizedBox()
                      else
                        GestureDetector(
                          onTap: () {
                            model.navigateToProfile(
                              id: model.users[index].userId!,
                              bio: model.users[index].aboutMe!,
                              photo: model.users[index].photoUrl!,
                              username: model.users[index].userName!,
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.myGreen,
                                  AppColors.myYellow,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: LeadingAvatar(
                                photo: model.users[index].photoUrl!),
                          ),
                        ),
                      const SizedBox(width: 10),
                      Text(
                        '@${model.posts[index].sentBy!}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: AppColors.myDarkGrey,
                          fontSize: 14,
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
              if (model.posts[index].photoUrl!.isEmpty)
                Container(
                  margin: const EdgeInsets.only(left: 60, right: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    model.posts[index].body!,
                    style: GoogleFonts.mulish(
                      fontSize: 15,
                    ),
                  ),
                )
              else
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 60, right: 15),
                      width: double.infinity,
                      child: Text(
                        model.posts[index].body!,
                        style: GoogleFonts.mulish(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(left: 50, right: 15),
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(model.posts[index].photoUrl!),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 45.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.heart,
                        size: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.bubble_right,
                        size: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.arrowshape_turn_up_right,
                        size: 22,
                      ),
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
