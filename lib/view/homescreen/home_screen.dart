import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/models.dart/icon_drawer.dart';
import 'package:spinchat/app/models.dart/user_model.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatView/chat_view_search_screen.dart';
import 'package:spinchat/widgets/app_wide_widgets/drawer.dart';
import 'package:spinchat/widgets/profile/users_circle_avatar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'home_screen_viewmodel.dart';

final _fireStore = locator<FirestoreService>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var theme = Theme.of(context);
    final bool _light = Theme.of(context).brightness == Brightness.light;
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        List<IconDrawer> listChoices = [
          IconDrawer(
            title: 'Theme',
            icon: Switch.adaptive(
                value: model.themePref!,
                onChanged: (val) {
                  model.toggleTheme(val);
                  getThemeManager(context).toggleDarkLightTheme();
                }),
            onpressed: () {
              model.toggleTheme;
              getThemeManager(context).toggleDarkLightTheme();
            },
          ),
          IconDrawer(
              title: 'Settings',
              icon: Icon(
                Icons.settings,
                color: _light ? AppColors.naveyBlue : AppColors.mylightGreen,
              ),
              onpressed: () {
                model.navigateToSettings();
              }),
        ];
        return Scaffold(
          key: scaffoldKey,
          drawer: AppDrawer(listChoices: listChoices),
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            leading: GestureDetector(
              onTap: () => scaffoldKey.currentState!.openDrawer(),
              child: Icon(
                Icons.menu,
                color: _light ? AppColors.naveyBlue : AppColors.white,
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
                icon: Icon(
                  Icons.search,
                  color: _light ? AppColors.naveyBlue : AppColors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  model.logout();
                },
                icon: Icon(Icons.logout,
                    color: _light ? AppColors.naveyBlue : AppColors.white),
              ),
            ],
            elevation: 1,
            title: Text(
              'BetBunker',
              style: GoogleFonts.poppins(),
            ),
          ),
          body: model.isbusy
              ? const Center(child: CircularProgressIndicator.adaptive())
              : RefreshIndicator(
                  onRefresh: () async {
                    await model.fetchPosts();
                  },
                  color: _light ? AppColors.myGreen : AppColors.white,
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
                child: Icon(
                  CupertinoIcons.pen,
                  color: _light ? AppColors.black : AppColors.white,
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
    final bool _light = Theme.of(context).brightness == Brightness.light;
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      separatorBuilder: (_, index) => const Divider(),
      itemCount: model.posts.length,
      itemBuilder: (_, __) {
        return StreamBuilder(
          stream: _fireStore.getUSerDetails(model.posts[__].createdBy),
          builder: (BuildContext ctx, AsyncSnapshot<Users> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return SizedBox(
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
                                model.navigateToProfile(
                                  id: snapshot.data!.userId!,
                                  bio: snapshot.data!.aboutMe!,
                                  photo: snapshot.data!.photoUrl!,
                                  username: snapshot.data!.userName!,
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
                                  photo: snapshot.data!.photoUrl!,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '@${snapshot.data!.userName}',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: _light ? AppColors.myDarkGrey : null,
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
                    if (model.posts[__].photoUrl!.isEmpty)
                      Container(
                        margin: const EdgeInsets.only(left: 60, right: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          model.posts[__].body!,
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
                              model.posts[__].body!,
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
                              border: Border.all(color: AppColors.myMediumGrey),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image:
                                      NetworkImage(model.posts[__].photoUrl!),
                                  fit: BoxFit.cover),
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
                            onPressed: () {
                              model.like(false, model.posts[__]);
                            },
                            icon: const Icon(
                              Icons.favorite_border,
                              size: 22,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.conversation_bubble,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.arrowshape_turn_up_right,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
