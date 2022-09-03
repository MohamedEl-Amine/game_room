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

class EditPostScreen extends StatefulWidget {
  final id;
  final oldname;
  EditPostScreen({Key? key, required this.id, required this.oldname})
      : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  late TextEditingController nameController =
      TextEditingController(text: widget.oldname);
  TextEditingController timeController = TextEditingController();
  Sqflite sqflite = Sqflite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Post'),
          backgroundColor: Color.fromRGBO(47, 143, 157, 1),
        ),
        body: Container(
          child: ListView(children: [
            Form(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
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
                      sqflite.updateData(
                          "UPDATE 'pespost' SET 'name' = '${nameController.text}' WHERE id = ${widget.id}");
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => PesScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text("Edit Post"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(47, 143, 157, 1)),
                    onPressed: () {
                      sqflite.deletData(
                          "DELETE FROM 'pespost' WHERE id = ${widget.id}");
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => PesScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text("Delete Post"),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
