import 'package:flutter/material.dart';
import 'package:note_app/presentation/ui/splash/widgets/splash_text.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/main_back.jpg',
          fit: BoxFit.cover,
        ),
        const Center(
          child: SplashText(),
        ),
      ],
    );
  }
}
