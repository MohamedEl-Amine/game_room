import 'package:flutter/material.dart';
import 'package:game_room/database/data_file.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Screens/splashScreen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  Sqflite sqflite = Sqflite();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Kaya game',
            theme: ThemeData(),
            home: SplashWidgetScreen());
      },
    );
  }
}
