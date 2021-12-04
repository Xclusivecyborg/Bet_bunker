import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/posts/posts.form.dart';
import 'package:spinchat/view/posts/posts_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TextEditor extends StatelessWidget with $Posts {
  final void Function(String) updatePostBody;
  TextEditor({Key? key, required this.updatePostBody}) : super(key: key);

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
            onChanged: updatePostBody,
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              hintText: 'Let\'s share some booking codes',
              hintStyle: GoogleFonts.poppins(
                color: AppColors.myDarkGrey,
                fontSize: 20,
              ),
              contentPadding: const EdgeInsets.only(top: 30, bottom: 20),
            ),
            textInputAction: TextInputAction.newline,
          );
        });
  }
}
