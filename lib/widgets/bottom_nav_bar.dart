import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/utils/app_styles.dart';
import 'package:spinchat/view/chatView/chat_view_screen.dart';
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
  List<Widget> selections = [];
  final _pageController = PageController();

  @override
  void initState() {
    setState(() {
      selections = [
        const ChatView(),
        const SearchScreen(),
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginScreenViewModel>.reactive(
      viewModelBuilder: () => LoginScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: PageView(
              controller: _pageController,
              children: selections,
              onPageChanged: (page) {
                setState(() {
                  selectedIndex = page;
                });
              }),
          bottomNavigationBar: BottomNavigationBar(
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
            unselectedItemColor: AppColors.myDarkGrey,
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
                label: 'Search',
                icon: Icon(Icons.search),
              ),
            ],
          ),
        );
      },
    );
  }
}
