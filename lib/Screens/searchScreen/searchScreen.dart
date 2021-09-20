import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/Screens/searchScreen/SearchScreen_viewmodel.dart';
import 'package:spinchat/utils/constants.dart';
import 'package:spinchat/widgets/custom_textfield.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchResults = new TextEditingController();
  // Map<String, dynamic>? snapshot;

  // getUSersByUsername() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   await firestore
  //       .collection('users')
  //       .where('name', isEqualTo: searchResults.text)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       snapshot = value.docs[0].data();
  //     });
  //     print(snapshot);
  //   });
  // }

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
            controller: searchResults,
            height: 40,
            bordercolor: Colors.white12,
            // onChange: model.getUSersByUsername(searchResults.text),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                model.getUSersByUsername(searchResults.text);
              },
              icon: Icon(Icons.menu, color: kMynaveyBlue),
            ),
          ],
        ),
        body: model.isBusy
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: model.snapshot!.length,
                itemBuilder: (context, index) => CustomTile(
                  username: model.snapshot![index].data()['name'],
                ),
              ),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String? username;
  CustomTile({
    Key? key,
    this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/rectangle.png'),
      ),
      title: Text(username!),
    );
  }
}
