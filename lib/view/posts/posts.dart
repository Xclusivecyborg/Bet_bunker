import 'package:flutter/material.dart';
import 'package:spinchat/view/posts/posts_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';


@FormView(
  fields: [
    FormTextField(name: 'posts'),
  ]
)
class Posts extends StatelessWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostsViewModel>.reactive(
        viewModelBuilder: () => PostsViewModel(),
        builder: (ctx, model, child) {
          return Scaffold(
            appBar: AppBar(),
          );
        });
  }
}
