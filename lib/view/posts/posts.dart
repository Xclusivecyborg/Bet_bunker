import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/posts/posts_viewmodel.dart';
import 'package:spinchat/widgets/posts/bottom_bar.dart';
import 'package:spinchat/widgets/posts/post_textfield.dart';
import 'package:spinchat/widgets/posts/selected_photo.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'posts'),
])
class Posts extends StatelessWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final bool _light = Theme.of(context).brightness == Brightness.light;
    return ViewModelBuilder<PostsViewModel>.reactive(
      viewModelBuilder: () => PostsViewModel(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: _light ? AppColors.naveyBlue : null,
              ),
              onPressed: model.pop,
            ),
            elevation: 2,
            title: Text(
              'create Post',
              style: GoogleFonts.poppins(
                color: _light ? AppColors.naveyBlue : null,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  model.textBody.isNotEmpty ? await model.createPost() : null;
                },
                child: Text(
                  'post',
                  style: GoogleFonts.poppins(
                    color: _light ? AppColors.naveyBlue : AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          body: SizedBox(
            child: Stack(children: [
              Positioned.fill(
                left: 20,
                right: 20,
                bottom: 50,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextEditor(
                        updatePostBody: model.onChange,
                      ),
                      SelectedPhoto(
                        photo: model.photoFile,
                        unpickImage: () {
                          model.unPickImage();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomBar(
                  pickImageCam: () {
                    model.pickImage(ImageSource.camera);
                  },
                  pickImageGal: () {
                    model.pickImage(ImageSource.gallery);
                  },
                  photo: model.photoFile,
                  unpickImage: () {
                    model.unPickImage();
                  },
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
