import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Instructions"),
      content: Container(
        width: 100,
        height: 400,
        child: ListView(
          children:<Widget>[
            Container(
              child: Text("* There are 16 Questions ",textScaleFactor: 1.3,),
            ),
            Container(
              child: Text("* Amount of each question can be seen by swiping from right to left to open endDrawer.",textScaleFactor: 1.3,),
            ),
            Container(
              child: Text("* There are 4 lifelines.",textScaleFactor: 1.3,),
            ),
            Container(
              child:Text("Lifelines",textScaleFactor: 1.5,style: TextStyle(color:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,decoration: TextDecoration.underline),)
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    Text("i.Audience Poll: ",style: TextStyle(fontWeight:FontWeight.bold),),
                    Text("You can take help from Audience."),
                  ]
                ), 
                TableRow(
                  children: [
                    Text("ii.50:50: ",style: TextStyle(fontWeight:FontWeight.bold),),
                    Text("Two incorrect options will be ommited."),
                  ]
                ),
                TableRow(
                  children: [
                    Text("iii.Phone a Friend: ",style: TextStyle(fontWeight:FontWeight.bold),),
                    Text("You can take help from your friend."),
                  ]
                ),
                TableRow(
                  children: [
                    Text("iv.Flip the Question: ",style: TextStyle(fontWeight:FontWeight.bold),),
                    Text("You can skip the current question."),
                  ]
                ),
              ]
            ),
            Container(
              child: Text("* Each lifeline can be used only once ",textScaleFactor: 1.3,),
            ),
           Container(
              child: Text("* User can quit anytime. ",textScaleFactor: 1.3,),
            ),
            Container(
              child: Text("* For first 4 questions, there is timer of 45 seconds. ",textScaleFactor: 1.3,),
            ),
            Container(
              child: Text("* There are two stages.First is at ₹ 10000 and second at ₹ 320000 ",textScaleFactor: 1.3,),
            ),
            Container(
              child: Text("* Amount will be given according to the stage cleared if given wrong answer. ",textScaleFactor: 1.3,),
            ),
            Container(
              child: Text("* If user wants to quit then current winning amount will be given. ",textScaleFactor: 1.3,),
            ),
            
          ]
        ),
      ),
      actions: <Widget>[
        FlatButton(child: Text("OK"),
        onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}