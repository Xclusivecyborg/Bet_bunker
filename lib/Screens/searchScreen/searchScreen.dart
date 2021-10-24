import 'package:flutter/material.dart';
import 'package:spinchat/Screens/searchScreen/SearchScreen_viewmodel.dart';
import 'package:spinchat/utils/constants.dart';
import 'package:spinchat/widgets/custom_textfield.dart';
import 'package:spinchat/widgets/custom_tile.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchScreenViewmodel>.reactive(
      viewModelBuilder: () => SearchScreenViewmodel(),
      builder: (ctx, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: kMynaveyBlue)),
          backgroundColor: KMyWhite,
          title: CustomTextField(
            autofocus: true,
            hintText: 'Search in chat',
            controller: model.searchResults,
            height: 40,
            bordercolor: Colors.white12,
            onChange: (val) {
              model.getUsers(val: val);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                model.getUSersByUsername();
              },
              icon: Icon(Icons.search, color: kMynaveyBlue),
            ),
          ],
        ),
        body: model.snapshot == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    thickness: 2,
                  ),
                  shrinkWrap: true,
                  itemCount: model.snapshot!.length,
                  itemBuilder: (context, index) => CustomTile(
                    username: model.snapshot![index].data()['name'],
                    ontap: () {
                      // ignore: unused_element
                      startConversation(String username) {
                        List<String> users = [
                          username,
                        ];
                        // model.chatRoomCreate(chatRoomId, data)
                      }
                    },
                  ),
                ),
              ),
      ),
    );
  }
}


