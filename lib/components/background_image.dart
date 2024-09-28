import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/main_back.jpg",
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );
  }
}
