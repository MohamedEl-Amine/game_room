import 'package:flutter/material.dart';

class AboutScreeen extends StatelessWidget {
  const AboutScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(36, 36, 36, 1),
        elevation: 0,
      ),
      backgroundColor: Color.fromRGBO(36, 36, 36, 1),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: size.height,
        width: size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "About Application",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                """This application really helps those working in the playroom, especially since it has many features that will make the work easier.
This application allows storing, modifying or deleting information.
This program was developed by M'edPro.""",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
