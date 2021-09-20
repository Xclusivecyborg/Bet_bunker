import 'package:flutter/material.dart';
import 'package:spinchat/Screens/chatView/chatViewScreen_viewModel.dart';
import 'package:spinchat/Screens/registrationPage/registrationPage.dart';
import 'package:spinchat/Screens/searchScreen/searchScreen.dart';
import 'package:spinchat/utils/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: KMyWhite,
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
                icon: Icon(Icons.search, color: kMynaveyBlue)),
            IconButton(
                onPressed: () {
                  model.authService.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Regiistration(),
                    ),
                  );
                },
                icon: Icon(Icons.logout, color: kMynaveyBlue)),
          ],
          elevation: 1,
          title: Text(
            'SpinChat',
            style: GoogleFonts.spinnaker(
              color: kMynaveyBlue,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kMynaveyBlue,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          },
          child: Icon(Icons.message),
        ),
      ),
    );
  }
}
