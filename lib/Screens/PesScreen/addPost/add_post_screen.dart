import 'package:flutter/material.dart';
import 'package:game_room/database/data_file.dart';

import '../pes_screen.dart';

//  "INSERT INTO 'notes' ('name') VALUES ('note one')"
//  "SELECT * FROM 'notes'"
//  "DELETE FROM 'notes' WHERE 'id' = 8"
//  "UPDATE 'notes' SET 'note' = 'note six' WHERE id = 5"

// Navigator.of(context).pushReplacement(
//   MaterialPageRoute(
//     builder: (context) => MyHomePage(),
//   ),
// );

class AddPostScreen extends StatefulWidget {
  AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  Sqflite sqflite = Sqflite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new Post'),
          backgroundColor: Color.fromRGBO(47, 143, 157, 1),
        ),
        body: Container(
          child: ListView(children: [
            Form(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: "Name"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(47, 143, 157, 1)),
                    onPressed: () {
                      sqflite.insertData(
                          "INSERT INTO 'pespost' ('name','numberofplays') VALUES ('${nameController.text}','0')");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PesScreen(),
                        ),
                      );
                    },
                    child: const Text("Add Post"),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
