import 'package:flutter/material.dart';

class CustomGestureDetectorWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final bool isGestureDetectorAvailable;

  CustomGestureDetectorWidget(
      {Key? key,
      required this.child,
      required this.isGestureDetectorAvailable,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isGestureDetectorAvailable
        ? GestureDetector(
            onTap: onTap,
            child: child,
          )
        : child;
  }
}
