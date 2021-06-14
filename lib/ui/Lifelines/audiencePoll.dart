import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class AudiencePoll extends StatefulWidget {
  final int op1,op2,op3,op4;
  AudiencePoll({this.op1,this.op2,this.op3,this.op4,});

  @override
  _AudiencePollState createState() => _AudiencePollState(op1: op1,op2: op2,op3: op3,op4: op4);
}

class _AudiencePollState extends State<AudiencePoll> {
  final int op1,op2,op3,op4;
  _AudiencePollState({this.op1,this.op2,this.op3,this.op4});



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey[200],
      title: Text("Audience Poll"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Bar(op1*0.01, "A",op1),
          Bar(op2*0.01, "B",op2),
          Bar(op3*0.01, "C",op3),
          Bar(op4*0.01, "D",op4),
        ],
      ),
      actions: <Widget>[
        FlatButton(child: Text("Ok"),
        onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}



class Bar extends StatelessWidget {
  final double height;
  final String label;
  final int bOp;

  final int _baseDurationMs = 1000;
  final double _maxElementHeight = 100;

  Bar(this.height, this.label,this.bOp);

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      duration: Duration(milliseconds: (height * _baseDurationMs).round()),
      tween: Tween(begin: 0.0, end: height),
      builder: (context, animatedHeight) {
        return Column(
          children: <Widget>[
            Text("$bOp"+"%"),
            Container(
              height: (1 - animatedHeight) * _maxElementHeight,
            ),
            Container(
              width: 20,
              height: animatedHeight * _maxElementHeight,
              color: Colors.blue,
            ),
            Text(label)
          ],
        );
      },
    );
  }
}