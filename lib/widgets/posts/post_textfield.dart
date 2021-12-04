import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/posts/posts.form.dart';
import 'package:spinchat/view/posts/posts_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TextEditor extends StatelessWidget with $Posts {
  TextEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostsViewModel>.reactive(
        viewModelBuilder: () => PostsViewModel(),
        builder: (ctx, model, child) {
          return TextFormField(
            textCapitalization: TextCapitalization.sentences,
            autofocus: true,
            controller: postsController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            cursorColor: AppColors.myGreen,
            style: const TextStyle(height: 1.7),
            // onChanged: model.updatePostBody,
            decoration: const InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              hintText: 'What\'s trending?',
              hintStyle: TextStyle(fontSize: 24, height: 1),
              contentPadding: EdgeInsets.only(top: 30, bottom: 20),
            ),
            textInputAction: TextInputAction.newline,
          );
        });
  }
}
