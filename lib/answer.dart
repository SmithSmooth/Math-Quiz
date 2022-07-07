import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

final titleController = TextEditingController();

class Answer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60,right: 10,left: 10,bottom: 40),
      child:  TextField(
        autofocus: true,
        controller: titleController,
        keyboardType: TextInputType.number,
        autocorrect: true,
        style: const TextStyle(
          fontSize: 36,
          fontFamily: "serif",
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          hintText: "Answer...",
          labelText: 'Type Your Answer',
          labelStyle: TextStyle(
            fontSize: 20,
            fontFamily: "serif",
            textBaseline: TextBaseline.alphabetic
          ),
          helperText: "If division, Write To 3 significant figures",
          helperStyle: TextStyle(
            fontSize: 18,
            fontFamily: "serif",
            overflow: TextOverflow.clip
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color:Color.fromARGB(255, 8, 177, 47) ),
              
              ),
          hintStyle: TextStyle(
            fontFamily: "serif",
            fontSize: 36,
          )
        
        ),
        ),
    );
  }
}
