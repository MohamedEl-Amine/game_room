// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_room/Welcome/main_welcome.dart';
import 'package:game_room/database/data_file.dart';

import 'AddAndEdit/add_person.dart';
import 'AddAndEdit/edit_person.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  Sqflite sqflite = Sqflite();
  bool isLoading = true;
  List<Map<dynamic, dynamic>> persons = [];
  List credit = [];
  num totalCredit = 0;

  refresh() {
    persons = [];
    credit = [];
    readData();
  }

  CalculatCredit() {
    num totalCredit = 0;
    for (var i in credit) {
      setState(() {
        totalCredit += int.parse(i["amount"]);
      });
    }
    return totalCredit;
  }

  Future readData() async {
    List<Map> response = await sqflite.readData("SELECT * FROM credit");
    List creditBase = await sqflite.readData("SELECT amount from credit");
    persons.addAll(response);
    credit.addAll(creditBase);
    isLoading = false;
    if (this.mounted) {
      setState(
        () {},
      );
    }
  }

  @override
  void initState() {
    readData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(36, 36, 36, 1),
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.r, top: 50.r, right: 20.r),
              height: 100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => MainWelcomeScreen()),
                                (Route<dynamic> route) => false);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 25.r,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          child: Text(
                            "Credit",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AddPersonScreen()),
                            );
                          },
                          icon: Icon(
                            Icons.add,
                            size: 36.r,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 5.h),
                    child: Text(
                      "Total of Person : ${persons.length}",
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                  ),
                  Text(
                    "Total of Credit : ${CalculatCredit()} DA",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10.r, left: 20.r, right: 20.r),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: persons.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Container(
                            height: 180.r,
                            margin: EdgeInsets.only(bottom: 20.r),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("icons/backgroundCredit.png"),
                                  fit: BoxFit.fill),
                              color: Color.fromRGBO(47, 143, 157, 1),
                              border: Border.all(width: 1.r),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15.r),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Container(
                                      height: 20.r,
                                      width: 20.r,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPersonScreen(
                                                // refreshFun: refresh(),
                                                oldAmount: persons[i]['amount'],
                                                oldName: persons[i]['name'],
                                                oldDate: persons[i]['date'],
                                                id: persons[i]['id'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          child: Image.asset(
                                            "icons/edit.png",
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.r,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 26.r,
                                    ),
                                    Container(
                                      height: 50.r,
                                      width: 50.r,
                                      child: Image.asset(
                                        "icons/user.png",
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 26.r,
                                    ),
                                    Text(
                                      '${persons[i]['name']}',
                                      style: TextStyle(
                                          fontSize: 20.sp, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 6.r,
                                ),
                                Text(
                                  '${persons[i]['amount']} DA',
                                  style: TextStyle(
                                      fontSize: 25.sp, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 15.r,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10.r,
                                    ),
                                    Text(
                                      'Date of Creation : ${persons[i]['date']}',
                                      style: TextStyle(
                                          fontSize: 10.sp, color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
