import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/auth_login.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final List<Color> colorizeColors = [
    const Color.fromRGBO(236, 177, 118, 1),
    const Color.fromRGBO(166, 123, 91, 1),
    Colors.grey,
    Colors.white,
  ];

  final colorizeTextStyle = const TextStyle(
      fontSize: 24.0, fontFamily: 'Inter', fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthLogin()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.brown,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              scale: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Solusi Terbaik',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'Sortir Biji Kopi',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: true,
              displayFullTextOnTap: true,
              pause: const Duration(seconds: 1),
            ),
          ],
        ),
      ),
    );
  }
}
