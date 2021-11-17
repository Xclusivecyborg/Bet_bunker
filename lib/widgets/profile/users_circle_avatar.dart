import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants/color_constants.dart';

class LeadingAvatar extends StatelessWidget {
  final String photo;

  const LeadingAvatar({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.network(
        photo,
        fit: BoxFit.cover,
        width: 40,
        height: 40,
        errorBuilder: (ctx, object, stackTrace) {
          return const Icon(
            Icons.account_circle,
            size: 40,
            color: AppColors.myDarkGrey,
          );
        },
        loadingBuilder: (ctx, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const SizedBox(
              height: 40,
              width: 40,
              child: Icon(
                Icons.account_circle,
                size: 40,
                color: AppColors.myDarkGrey,
              ),
            );
          }
        },
      ),
    );
  }
}
