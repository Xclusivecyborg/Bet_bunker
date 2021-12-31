import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatView/chat_view_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileAvatar extends StatelessWidget {
  final String photosUrl;
  const ProfileAvatar({
    Key? key,
    required this.photosUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _light = Theme.of(context).brightness == Brightness.light;
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(),
      builder: (ctx, model, child) => Container(
        margin: const EdgeInsets.all(20),
        child: photosUrl.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.whiteGrey,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 7,
                      color:
                          _light ? AppColors.naveyBlue : AppColors.mylightGreen,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(55),
                  child: Image.network(
                    photosUrl,
                    fit: BoxFit.cover,
                    width: 110,
                    height: 110,
                    errorBuilder: (ctx, object, stackTrace) {
                      return const Icon(
                        Icons.account_circle,
                        size: 90,
                        color: AppColors.myDarkGrey,
                      );
                    },
                    loadingBuilder: (ctx, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        // ignore: sized_box_for_whitespace
                        return Container(
                          height: 90,
                          width: 90,
                          child: Center(
                            child: CircularProgressIndicator.adaptive(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
            : const Icon(
                Icons.account_circle,
                size: 120,
                color: AppColors.myDarkGrey,
              ),
      ),
    );
  }
}
