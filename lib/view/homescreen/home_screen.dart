import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/app/models.dart/icon_drawer.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatView/chat_view_search_screen.dart';
import 'package:spinchat/widgets/app_wide_widgets/drawer.dart';
import 'package:spinchat/widgets/app_wide_widgets/shimmer_loader.dart';
import 'package:spinchat/widgets/posts/list_of_posts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'home_screen_viewmodel.dart';

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
        return Scaffold(
          key: scaffoldKey,
          drawer: AppDrawer(
            listChoices:
                getIconDrawer(model: model, context: context, light: _light),
          ),
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
                  model.logout();
                },
                icon: Icon(
                  Icons.logout,
                  color: _light ? AppColors.naveyBlue : null,
                ),
              ),
            ],
            elevation: 1,
            title: Text(
              'BetBunker',
              style: GoogleFonts.poppins(
                color: _light ? AppColors.naveyBlue : null,
              ),
            ),
          ),
          body: model.isbusy
              ? const ShimmerWidget()
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

List<IconDrawer> getIconDrawer(
    {required HomeScreenViewModel model,
    required BuildContext context,
    required light}) {
  return [
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
          color: light ? AppColors.naveyBlue : AppColors.mylightGreen,
        ),
        onpressed: () {
          model.navigateToSettings();
        }),
  ];
}
