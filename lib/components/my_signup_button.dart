import 'package:flutter/material.dart';

class MyButtonWithImg extends StatelessWidget {
  final String imagePath;
  final String buttonName;

  const MyButtonWithImg(
      {super.key, required this.buttonName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 25.0,
            height: 25.0,
          ),
          SizedBox(width: 16.0),
          Text(
            buttonName,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
