import 'package:flutter/material.dart';

class IconDrawer {
  final String title;
  final Widget icon;
  final Function() onpressed;

  IconDrawer({required this.onpressed, required this.title, required this.icon});
}
