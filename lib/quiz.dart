import 'package:flutter/material.dart';
import 'dart:math';

class MyQuestions extends StatelessWidget {
  final String ans;
  
   MyQuestions(this.ans);

  String get mathToShow {
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      padding: const EdgeInsets.only(top: 50),
      child: Column(children: [
        Text(
          mathToShow,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: "serif"),
        ),
        
      ]),
    );
  }
}
