import 'package:flutter/material.dart';
import 'package:spinchat/Screens/searchScreen/SearchScreen_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchScreenViewmodel>.reactive(
      viewModelBuilder: () => SearchScreenViewmodel(),
      builder: (ctx, model, child) => Scaffold(
        appBar: AppBar(
          title: TextField(),
        ),
      ),
    );
  }
}
