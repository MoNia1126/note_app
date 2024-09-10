import 'dart:async';
import 'package:flutter/material.dart';
import 'package:note_app/cache_helper.dart';
import 'package:note_app/home/home_screen.dart';
import 'package:note_app/home/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
          () {
        if (CacheHelper.getString(key: "userId").isNotEmpty) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var mediaQuary =
    //     MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/main_back.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              'Notes App',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}