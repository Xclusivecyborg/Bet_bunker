import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/app/models.dart/user_model.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/homescreen/home_screen_viewmodel.dart';
import 'package:spinchat/widgets/app_wide_widgets/shimmer_loader.dart';
import 'package:spinchat/widgets/profile/users_circle_avatar.dart';

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
          stream: model.fireStore.getUSerDetails(model.posts[__].createdBy),
          builder: (BuildContext ctx, AsyncSnapshot<Users> snapshot) {
            if (!snapshot.hasData) {
              return const Shimmer();
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
