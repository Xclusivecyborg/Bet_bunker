// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
            title: Text('create Post'),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text('create'),
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
                      TextEditor(),
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

