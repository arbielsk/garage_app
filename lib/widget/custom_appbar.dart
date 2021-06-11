import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTap;
  final AppBar appBar;
  final bool isGestureDetectorAvailable;

  CustomAppBar(
      {Key? key,
      required this.appBar,
      required this.onTap,
      required this.isGestureDetectorAvailable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isGestureDetectorAvailable
        ? GestureDetector(
            onTap: onTap,
            child: appBar,
          )
        : appBar;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
