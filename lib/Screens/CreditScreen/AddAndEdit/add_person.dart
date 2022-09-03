import 'package:flutter/material.dart';

import '../../../database/data_file.dart';
import '../credit_screen.dart';

class AddPersonScreen extends StatefulWidget {
  const AddPersonScreen({Key? key}) : super(key: key);

  @override
  State<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController(
    text: '${DateTime.now()}'.substring(0, 10).split('-').reversed.join('/'),
  );

  datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((Date) {
      setState(() {
        String newDate = Date.toString().substring(0, 10);
        dateController.text = newDate.split('-').reversed.join('/');
      });
    });
  }

  static final _formKey = new GlobalKey<FormState>();
  Sqflite sqflite = Sqflite();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new Person'),
          backgroundColor: Color.fromRGBO(36, 36, 36, 1),
        ),
        body: Container(
          child: ListView(children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: "Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return true;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(hintText: "Amount"),
                      validator: (value) {
                        try {
                          int.parse(value!);
                          return null;
                        } catch (e) {
                          return 'Please enter Correct number';
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          width: size.width * 0.85,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            controller: dateController,
                            decoration: const InputDecoration(hintText: "Date"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            datePicker();
                          },
                          child: Container(
                            height: 50,
                            width: 20,
                            child: Icon(
                              Icons.calendar_month_rounded,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(36, 36, 36, 1),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        sqflite.insertData(
                            "INSERT INTO 'credit' ('name','amount','date') VALUES ('${nameController.text}','${amountController.text}','${dateController.text}')");
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => CreditScreen()),
                            (Route<dynamic> route) => false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Done'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    child: const Text("Add Person"),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
