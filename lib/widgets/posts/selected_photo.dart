import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/posts/posts_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SelectedPhoto extends StatelessWidget {
  const SelectedPhoto({Key? key, required this.photo, this.unpickImage})
      : super(key: key);
  final Function()? unpickImage;
  final File? photo;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostsViewModel>.reactive(
      viewModelBuilder: () => PostsViewModel(),
      builder: (ctx, model, child) {
        if (photo == null) {
          return const SizedBox();
        } else {
          return Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              color: AppColors.myBlue,
              image: DecorationImage(
                image: FileImage(photo!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.topLeft,
              child: Material(
                shape: const CircleBorder(),
                color: Colors.white,
                child: IconButton(
                  onPressed: unpickImage,
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
