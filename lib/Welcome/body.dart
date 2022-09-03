import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Screens/BillardScreen/billard_screen.dart';
import '../Screens/CreditScreen/credit_screen.dart';
import '../Screens/PesScreen/pes_screen.dart';
import '../components/cusstom_button.dart';
import 'background.dart';

class BodyScreenWelcome extends StatefulWidget {
  const BodyScreenWelcome({Key? key}) : super(key: key);

  @override
  State<BodyScreenWelcome> createState() => _BodyScreenWelcomeState();
}

class _BodyScreenWelcomeState extends State<BodyScreenWelcome> {
  @override
  Widget build(BuildContext context) {
    return HomePageScreen(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => BillardScreen()),
                    (Route<dynamic> route) => false);
              },
              child: Container(
                width: 130.r,
                height: 120.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(44, 60, 83, 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 80.r,
                        height: 80.r,
                        child: Image.asset('icons/pool.png')),
                    Text(
                      'Billard',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => PesScreen()),
                    (Route<dynamic> route) => false);
              },
              child: Container(
                width: 130.r,
                height: 120.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(44, 60, 83, 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 80.r,
                        height: 80.r,
                        child: Image.asset('icons/pes.png')),
                    Text(
                      'Pes',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => CreditScreen(),
                    ),
                    (Route<dynamic> route) => false);
              },
              child: Container(
                width: 130.r,
                height: 120.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(44, 60, 83, 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 80.r,
                        height: 80.r,
                        child: Image.asset('icons/book.png')),
                    Text(
                      'Credit',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Text("by Med Elamine")
          ],
        ),
      ),
    );
  }
}
