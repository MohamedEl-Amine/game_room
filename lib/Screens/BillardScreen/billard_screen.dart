import 'package:flutter/material.dart';
import 'package:game_room/database/data_file.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Welcome/main_welcome.dart';

//  "INSERT INTO 'notes' ('name') VALUES ('note one')"
//  "SELECT * FROM 'notes'"
//  "DELETE FROM 'notes' WHERE 'id' = 8"
//  "UPDATE 'notes' SET 'note' = 'note six' WHERE id = 5"

// Navigator.of(context).pushReplacement(
//   MaterialPageRoute(
//     builder: (context) => MyHomePage(),
//   ),
// );

class BillardScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<BillardScreen> {
  Sqflite sqflite = Sqflite();
  List<Map<dynamic, dynamic>> names = [];
  bool isDone = true;

  paidState(id) {
    var item = names.firstWhere((i) => i["id"] == id); // getting the item
    var index = names.indexOf(item);

    List<Map<dynamic, dynamic>> newUser =
        List<Map<dynamic, dynamic>>.from(names);
    newUser[index]['isdone'] = 'Not Paid';
  }

  Future readData() async {
    List<Map> response = await sqflite.readData("SELECT * FROM notes");
    names.addAll(response);
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
    TextEditingController nameController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.h, left: 10.w),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => MainWelcomeScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 10.w),
                        child: Icon(Icons.arrow_back_ios))),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Text(
              'List Player',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.h),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Player Name',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: ElevatedButton(
              child: Text(
                'Add',
                style: TextStyle(fontSize: 14.sp),
              ),
              onPressed: () {
                sqflite.insertData(
                    "INSERT INTO 'notes' ('name','isdone') VALUES ('${nameController.text}','Not Paid')");

                setState(() {
                  names = [];
                  readData();
                  // names;
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: names.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                            title: Text(
                                "${i + 1} - ${names[i]['name']} (${names[i]['isdone']})"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    if (names[i]['isdone'] == 'Not Paid') {
                                      int response = await sqflite.deletData(
                                          "UPDATE 'notes' SET 'isdone' = 'Paid' WHERE id = ${names[i]['id']}");
                                      setState(() {
                                        names = [];
                                        readData();
                                        // names;
                                      });
                                    }
                                    if (names[i]['isdone'] == 'Paid') {
                                      int response = await sqflite.deletData(
                                          "UPDATE 'notes' SET 'isdone' = 'Not Paid' WHERE id = ${names[i]['id']}");

                                      setState(() {
                                        names = [];
                                        readData();
                                        // names;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.done,
                                    color: isDone ? Colors.green : Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    int response = await sqflite.deletData(
                                        "DELETE FROM notes WHERE id = ${names[i]['id']}");
                                    if (response > 0) {
                                      // Navigator.of(context).pushReplacement(
                                      //   MaterialPageRoute(
                                      //     builder: (context) => MyHomePage(),
                                      //   ),
                                      // );

                                      names.removeWhere((element) =>
                                          element['id'] == names[i]['id']);
                                      setState(() {});
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
