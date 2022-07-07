import 'package:flutter/material.dart';
import './answer.dart';


class Result extends StatelessWidget {
  final void Function()? nextQuiz;

  const Result(this.nextQuiz);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: nextQuiz,
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 8, 177, 47),
                )),
            child: const Text(
              "Next Question",
              style: TextStyle(
                  fontSize: 34,
                  fontFamily: "serif",
                  fontWeight: FontWeight.bold),
            )));
  }
}
