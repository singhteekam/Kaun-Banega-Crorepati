import 'package:flutter/material.dart';

class PhoneAFriend extends StatefulWidget {
  final String ques,opt1,opt2,opt3,opt4,answ;
  PhoneAFriend({this.answ,this.opt1,this.opt2,this.opt3,this.opt4,this.ques});

  @override
  _PhoneAFriendState createState() => _PhoneAFriendState(ques: ques,opt1: opt1,opt2:opt2,opt3: opt3,opt4: opt4,answ: answ);
}

class _PhoneAFriendState extends State<PhoneAFriend> {

  final String ques,opt1,opt2,opt3,opt4,answ;
  _PhoneAFriendState({this.answ,this.opt1,this.opt2,this.opt3,this.opt4,this.ques});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Phone A Friend"),
      content: Container(
        width: 100,
        height: 400,
        child: ListView(
          children:<Widget>[
            Container(
              child:Text("Q. $ques")
            ),
            Container(
              child:Text("A. $opt1")
            ),
            Container(
              child:Text("B. $opt2")
            ),
            Container(
              child:Text("C. $opt3")
            ),
            Container(
              child:Text("D. $opt4")
            ),
            Divider(),
            Container(
              color: Colors.green[200],
              child:Text("Correct Answer is : $answ",textScaleFactor: 1.3,)
            ),
          ]
        ),
      ),
      actions: <Widget>[
        FlatButton(child: Text("Ok"),
        onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}