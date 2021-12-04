import 'dart:io';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar(
      {Key? key,
      required this.photo,
      required this.unpickImage,
      this.pickImageCam,
      this.pickImageGal})
      : super(key: key);
  final File? photo;
  final Function()? pickImageCam;
  final Function()? pickImageGal;
  final Function()? unpickImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            IconButton(
              onPressed: photo != null ? null : pickImageGal,
              icon:const Icon(Icons.image),
            ),
            IconButton(
              onPressed: photo != null ? null : pickImageCam,
              icon:const Icon(Icons.camera),
            ),
          ],
        ),
      ),
    );
  }
}
