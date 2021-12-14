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
    return ViewModelBuilder<PostsViewModel>.reactive(
      viewModelBuilder: () => PostsViewModel(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.naveyBlue,
              ),
              onPressed: model.pop,
            ),
            backgroundColor: AppColors.white,
            elevation: 1,
            title: Text(
              'create Post',
              style: GoogleFonts.poppins(
                color: AppColors.naveyBlue,
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
                    color: AppColors.naveyBlue,
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
