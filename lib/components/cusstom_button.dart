import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onClicked;
  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: size.height * 0.17,
        width: size.width * 0.35,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(44, 60, 83, 1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(blurRadius: 1)],
          // border: Border.all(color: Colors.black, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // margin: EdgeInsets.all(5),
              width: 80,
              height: 80,
              child: Image.asset(icon),
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
