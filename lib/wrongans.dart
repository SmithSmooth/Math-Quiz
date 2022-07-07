import 'dart:ffi';

import 'package:flutter/material.dart';

class WrongAns extends StatelessWidget {
  final String quesFailed;
  final String correctAns;
  final String userWrongAns;

  WrongAns(this.quesFailed, this.correctAns, this.userWrongAns);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                quesFailed,
                textAlign: TextAlign.left,
                style: const TextStyle(fontFamily: "serif", fontSize: 30),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                correctAns,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "serif",
                    fontSize: 30,
                    color: Color.fromARGB(255, 54, 198, 32)),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                userWrongAns,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontFamily: "serif",
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 0, 0)),
              ),
            ),
          ],
        ));
  }
}
