import 'package:flutter/material.dart';
import 'package:spinchat/Screens/chatscreen/chatScreenViewmodel.dart';
import 'package:spinchat/Screens/searchScreen/searchScreen.dart';
import 'package:spinchat/utils/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatScreenViewmodel>.reactive(
      viewModelBuilder: () => ChatScreenViewmodel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, color: kMynaveyBlue)),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.menu, color: kMynaveyBlue)),
          ],
          elevation: 1,
          title: Text(
            'SpinChat',
            style: GoogleFonts.spinnaker(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
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
