

import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants/color_constants.dart';

Container onlineStatusDot({bool isOnline = false}) {
  return Container(
    height: 10,
    width: 10,
    decoration: BoxDecoration(
      color: isOnline ? AppColors.myGreen : Colors.transparent,
      shape: BoxShape.circle,
    ),
  );
}