import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/view/chatView/chatViewScreen.dart';
import 'package:spinchat/view/searchScreen/searchScreen.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/widgets/text_styles.dart';

class IndexScreen extends StatefulWidget {
  final String username;
  const IndexScreen({Key? key, required this.username}) : super(key: key);

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  bool homepage = false;
  int selectedIndex = 0;
  List? selections;

  @override
  void initState() {
    setState(() {
      selections = [
        ChatView(
          username: widget.username,
        ),
        SearchScreen(),
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selections!.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: AppTextStyle.darkGreySize14Bold,
        unselectedLabelStyle: AppTextStyle.darkGreySize14
            .copyWith(fontSize: 14, color: AppColors.myDarkGrey),
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
        iconSize: 30,
        selectedItemColor: AppColors.myGreen,
        showUnselectedLabels: true,
        unselectedItemColor: AppColors.myLightGrey,
        items: [
          BottomNavigationBarItem(
            backgroundColor: AppColors.white,
            label: 'Home',
            icon: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: selectedIndex == 0
                    ? AppColors.myLightGreen
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const ImageIcon(
                AssetImage('assets/Vector.png'),
              ),
            ),
          ),
          const BottomNavigationBarItem(
            backgroundColor: AppColors.white,
            label: 'Search',
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
