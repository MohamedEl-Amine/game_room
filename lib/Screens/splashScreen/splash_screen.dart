import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import '../../Welcome/body.dart';
import '../../Welcome/main_welcome.dart';
import '../../main.dart';

class SplashWidgetScreen extends StatelessWidget {
  SplashWidgetScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 1,
        navigateAfterSeconds: MainWelcomeScreen(),
        title: const Text(
          "M'edPro",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
        image: Image.asset(
          'icons/logosplash.png',
        ),
        photoSize: 70.0,
        backgroundColor: Color.fromRGBO(36, 36, 36, 1),
        styleTextUnderTheLoader: const TextStyle(),
        loaderColor: Colors.white);
  }
}
