import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import './quiz.dart';
import 'dart:math';
import './answer.dart';
import './result.dart';
import './wrongans.dart';

void main() {
  runApp(const MyQuiz());
}

class MyQuiz extends StatefulWidget {
  const MyQuiz({Key? key}) : super(key: key);

  @override
  State<MyQuiz> createState() {
    return _MyQuizState();
  }
}

class _MyQuizState extends State<MyQuiz> {
  List<String> signs = [" - ", " + ", " x ", " ÷ "];
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  String get randomSign {
    final random = Random();
    var i = random.nextInt(signs.length);
    return signs[i];
  }

  String get randomNum1 {
    final random = Random();
    var i1 = random.nextInt(numbers.length);
    var i2 = random.nextInt(numbers.length);
    var num1 = i1.toString() + i2.toString();
    return num1.toString();
  }

  String get randomNum2 {
    final random = Random();
    var i1 = random.nextInt(numbers.length);
    var i2 = random.nextInt(numbers.length);
    var num2 = i1.toString() + i2.toString();
    return num2.toString();
  }

  // ignore: deprecated_member_use
  List questions = [];
  var index = 20;
  var listIndex = 0;

  List userAnswers = [];

  void generateQuiz() {
    while (questions.length < index) {
      final a = randomNum1;
      final b = randomNum2;
      final c = randomSign;
      if (c == " + ") {
        questions
            .add({"ques": (a + c + b), "ans": (int.parse(a) + int.parse(b))});
      } else if (c == " - ") {
        questions
            .add({"ques": (a + c + b), "ans": (int.parse(a) - int.parse(b))});
      } else if (c == " x ") {
        questions
            .add({"ques": (a + c + b), "ans": (int.parse(a) * int.parse(b))});
      } else if (c == " ÷ ") {
        var d = (int.parse(a) / int.parse(b));
        questions.add({"ques": (a + c + b), "ans": d.toStringAsFixed(3)});
      }

      index--;
    }

    print(questions);
  }

  void nextQuiz() {
    setState(() {
      userAnswers.add(titleController.text);
      titleController.text = "";

      listIndex++;

      print(userAnswers);
    });
  }

  List correctAns = [];
  List wrongAns = [];
  List wrongAnsIndex = [];
  var finalScore = "You Did It ";
  List correctedWrongAns = [];

  List<Widget> _cardList = [];

  void calculateScore() {
    for (var i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i].toString() == questions[i]["ans"].toString()) {
        correctAns.add("correct");
      } else {
        wrongAnsIndex.add(i);
        wrongAns.add("wrong");
      }
    }

    for (var i = 0; i < wrongAnsIndex.length; i++) {
      var dc;
      if (userAnswers[wrongAnsIndex[i]].length == 0) {
        dc = "Blank";
      } else {
        dc = userAnswers[wrongAnsIndex[i]];
      }
      correctedWrongAns.add({
        "quesFailed": questions[wrongAnsIndex[i]]["ques"],
        "correctAns": questions[wrongAnsIndex[i]]["ans"],
        "userWrongAns": dc
      });
    }

    //print(correctedWrongAns);

    setState(() {
      if (!finalScore.contains("!!")) {
        if (correctAns.length < 5) {
          finalScore =
              "You Got ${correctAns.length} out of 10. Try Harder Next Time !!";
        } else if (correctAns.length > 5) {
          finalScore =
              "You Got ${correctAns.length} out of 10. You are a Genius !! ";
        }
      }

      if (_cardList.isEmpty) {
        if (correctedWrongAns.isEmpty) {
          Widget _card() {
            return WrongAns("You", "Didn't fail", "Any Question.");
          }

          _cardList.add(_card());
        } else {
          for (var i = 0; i < correctedWrongAns.length; i++) {
            Widget _card() {
              return WrongAns(
                  correctedWrongAns[i]["quesFailed"] + " = ",
                  correctedWrongAns[i]["correctAns"].toString(),
                  correctedWrongAns[i]["userWrongAns"]);
            }

            _cardList.add(_card());
          }
        }
      }
    });
  }

  void restartQuiz() {
    setState(() {
      questions = [];
      correctAns = [];
      wrongAns = [];
      listIndex = 0;
      finalScore = "You Did It ";
      userAnswers = [];
      index = 20;
      correctedWrongAns = [];
      wrongAnsIndex = [];
      _cardList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Math Quiz",
              style: TextStyle(
                fontFamily: "serif",
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            titleSpacing: 4,
            backgroundColor: const Color.fromARGB(255, 8, 177, 47),
            elevation: 0,
          ),
          body: questions.length != 10
              ? Center(
                  child: ElevatedButton(
                      onPressed: (() => setState(() {
                            generateQuiz();
                          })),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10)),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 8, 177, 47),
                          )),
                      child: const Text(
                        "Start Quiz",
                        style: TextStyle(
                            fontSize: 34,
                            fontFamily: "serif",
                            fontWeight: FontWeight.bold),
                      )))
              : listIndex >= 10
                  ? Column(
                      verticalDirection: VerticalDirection.down,
                      children: [
                        Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 50, bottom: 20),
                            child: Text(finalScore,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: "serif",
                                    fontWeight: FontWeight.bold))),
                        Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(20),
                            child: ElevatedButton(
                              onPressed: calculateScore,
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 8, 177, 47),
                                  )),
                              child: const Text(
                                "Your Score",
                                style: TextStyle(
                                    fontFamily: "serif", fontSize: 30),
                              ),
                            )),
                        Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(20),
                            child: ElevatedButton(
                              onPressed: restartQuiz,
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 8, 177, 47),
                                  )),
                              child: const Text(
                                "Restart Quiz",
                                style: TextStyle(
                                    fontFamily: "serif", fontSize: 30),
                              ),
                            )),
                        const Text(
                          "Failed Questions",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "serif",
                              fontSize: 34),
                        ),
                        Expanded(
                            child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: _cardList.length,
                          itemBuilder: (context, indeg) {
                            return _cardList[indeg];
                          },
                        ))
                      ],
                    )
                  : Column(
                      children: [
                        MyQuestions(questions[listIndex]["ques"] as String),
                        Answer(),
                        Result(nextQuiz)
                      ],
                    )),
    );
  }
}
