import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Welcome/main_welcome.dart';
import '../../database/data_file.dart';
import 'addPost/add_post_screen.dart';
import 'addPost/edit_pes_screen.dart';

class PesScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<PesScreen> {
  Sqflite sqflite = Sqflite();
  bool isLoading = true;
  List<Map<dynamic, dynamic>> postes = [];

  Future readData() async {
    List<Map> response = await sqflite.readData("SELECT * FROM pespost");
    List timeReponse = await sqflite.readData("SELECT 'time' FROM pespost");
    postes.addAll(response);
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
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.r),
              height: 150.h,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.elliptical(100, 80)),
                color: Color.fromRGBO(47, 143, 157, 1),
              ),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20.w, top: 30.h),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => MainWelcomeScreen()),
                              (Route<dynamic> route) => false);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 24.r,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 30.h, right: 20.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddPostScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add Post",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            // Icon(
                            //   Icons.add,
                            //   color: Colors.black,
                            //   size: 30,
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.r),
                  child: Text(
                    'PES Games',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20.r, right: 20.r),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: postes.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 20.r),
                            height: 170.r,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "icons/backgroundPesScreen.png"),
                                  fit: BoxFit.fill),
                              color: Color.fromRGBO(47, 143, 157, 1),
                              border: Border.all(width: 1.w),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 19.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 24.r,
                                      width: 24.r,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditPostScreen(
                                                        id: postes[i]['id'],
                                                        oldname: postes[i]
                                                            ['name']),
                                              ),
                                            );
                                          },
                                          child: Container(
                                              child: Image.asset(
                                                  "icons/edit.png"))),
                                    ),
                                    Text(
                                      "${postes[i]['name']}",
                                      style: TextStyle(fontSize: 24.sp),
                                    ),
                                    Container(
                                      height: 24.r,
                                      width: 24.r,
                                      child: GestureDetector(
                                        onTap: () {
                                          sqflite.updateData(
                                              "UPDATE 'pespost' SET 'numberofplays' = '0' WHERE id = ${postes[i]['id']}");
                                          setState(
                                            () {
                                              postes = [];
                                              readData();
                                              // names;
                                            },
                                          );
                                        },
                                        child: Container(
                                            child:
                                                Image.asset("icons/reset.png")),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.r,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(),
                                    Container(
                                      height: 40.r,
                                      width: 23.r,
                                      child: GestureDetector(
                                        onTap: () {
                                          int number = int.parse(
                                              "${postes[i]['numberofplays']}");
                                          if (number != 0) {
                                            int newnumber = number - 1;
                                            sqflite.updateData(
                                                "UPDATE 'pespost' SET 'numberofplays' = '${newnumber}' WHERE id = ${postes[i]['id']}");
                                            setState(
                                              () {
                                                postes = [];
                                                readData();
                                                // names;
                                              },
                                            );
                                          }
                                        },
                                        child: Container(
                                            child: Image.asset(
                                                "icons/DownArrow.png")),
                                      ),
                                    ),
                                    Text(
                                      "${postes[i]['numberofplays']}",
                                      style: TextStyle(fontSize: 64.sp),
                                    ),
                                    Container(
                                      height: 40.r,
                                      width: 23.r,
                                      child: GestureDetector(
                                          onTap: () {
                                            int number = int.parse(
                                                "${postes[i]['numberofplays']}");
                                            int newnumber = number + 1;
                                            sqflite.updateData(
                                                "UPDATE 'pespost' SET 'numberofplays' = '${newnumber}' WHERE id = ${postes[i]['id']}");
                                            setState(
                                              () {
                                                postes = [];
                                                readData();
                                                // names;
                                              },
                                            );
                                          },
                                          child: Container(
                                              child: Image.asset(
                                                  "icons/UpArrow.png"))),
                                    ),
                                    Container(),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Text(
                        "by Mohamed Elamine",
                        style: TextStyle(fontSize: 12.sp),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
