import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/app/models.dart/icon_drawer.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatView/chat_view_search_screen.dart';
import 'package:spinchat/widgets/drawer.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var scaffoldKey = GlobalKey<ScaffoldState>();
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
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
                  color:
                      model.isWhite ? AppColors.myGreen : AppColors.naveyBlue,
                ),
                onpressed: () {
                  model.navigateToSettings();
                }),
          ];
        return Scaffold(
          key: scaffoldKey,
            drawer: AppDrawer(listChoices: listChoices),
             appBar: AppBar(
              backgroundColor:
                AppColors.white,
              leading: GestureDetector(
                onTap: () => scaffoldKey.currentState!.openDrawer(),
                child:const Icon(
                  Icons.menu,
                  color:
                      AppColors.naveyBlue,
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
                'SpinChat',
                style: GoogleFonts.poppins(
                  color:
                       AppColors.naveyBlue,
                ),
              ),
            ),
          
        );
      },
    );
  }
}
