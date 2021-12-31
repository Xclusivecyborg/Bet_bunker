import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/utils/app_styles.dart';
import 'package:spinchat/view/chatView/chat_view_screen.dart';
import 'package:spinchat/view/homescreen/home_screen.dart';
import 'package:spinchat/view/loginScreen/login_screen_viewmodel.dart';
import 'package:spinchat/view/chatView/chat_view_search_screen.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:stacked/stacked.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({
    Key? key,
  }) : super(key: key);

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  bool homepage = false;
  int selectedIndex = 0;
  // List<Widget> selections = [
  //   const HomeScreen(),
  //   const ChatView(),
  //   const SearchScreen(),
  // ];
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final bool _light = Theme.of(context).brightness == Brightness.light;
    return ViewModelBuilder<LoginScreenViewModel>.reactive(
      viewModelBuilder: () => LoginScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: PageView(
              controller: _pageController,
              children: [_getPageView(selectedIndex)],
              onPageChanged: (page) {
                setState(() {
                  selectedIndex = page;
                });
              }),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: _light
                  ? null
                  : const Border.symmetric(
                      horizontal: BorderSide(color: AppColors.white),
                    ),
            ),
            child: BottomNavigationBar(
              selectedLabelStyle: AppTextStyles.bottombar,
              unselectedLabelStyle: AppTextStyles.child1
                  .copyWith(fontSize: 14, color: AppColors.myDarkGrey),
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
                _pageController.jumpToPage(index);
              },
              currentIndex: selectedIndex,
              iconSize: 30,
              selectedItemColor: AppColors.myGreen,
              showUnselectedLabels: true,
              unselectedItemColor:
                  _light ? AppColors.myDarkGrey : AppColors.whiteGrey,
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: AppColors.white,
                  label: 'Home',
                  icon: Icon(
                    Icons.home_filled,
                  ),
                ),
                BottomNavigationBarItem(
                  backgroundColor: AppColors.white,
                  label: 'Chat',
                  icon: Icon(
                    CupertinoIcons.paperplane_fill,
                  ),
                ),
                BottomNavigationBarItem(
                  backgroundColor: AppColors.white,
                  label: 'Search',
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

_getPageView(int index) {
  switch (index) {
    case 0:
      return const HomeScreen();
    case 1:
      return const ChatView();
    case 2:
      return const SearchScreen();
  }
}
