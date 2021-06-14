
import 'package:KBC/ui/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:KBC/widgets/customButton.dart';

class FinalPage extends StatefulWidget {
  final amount;
  final quesAttempted;
  final finalQues;
  final finalOpt1;
  final finalOpt2;
  final finalOpt3;
  final finalOpt4;
  final finalAns;
  final int isQuit;
  FinalPage(
      this.amount,
      this.quesAttempted,
      this.finalQues,
      this.finalOpt1,
      this.finalOpt2,
      this.finalOpt3,
      this.finalOpt4,
      this.finalAns,
      this.isQuit);

  @override
  _FinalPageState createState() => _FinalPageState(amount, quesAttempted,
      finalQues, finalOpt1, finalOpt2, finalOpt3, finalOpt4, finalAns, isQuit);
}

class _FinalPageState extends State<FinalPage> {
  int amount;
  final quesAttempted;
  final finalQues;
  final finalOpt1;
  final finalOpt2;
  final finalOpt3;
  final finalOpt4;
  final finalAns;
  final int isQuit;
  _FinalPageState(
    this.amount,
    this.quesAttempted,
    this.finalQues,
    this.finalOpt1,
    this.finalOpt2,
    this.finalOpt3,
    this.finalOpt4,
    this.finalAns,
    this.isQuit,
  );
  int wAmount;
  FirebaseUser user;
  String msg99;

  final fb = Firestore.instance;

  String currTime, currDate;

  @override
  void initState() {
    print(DateTime.now().toIso8601String().substring(0, 10));
    getCurrentTime();
    initUser();
    if (isQuit == 0) {
      if (amount < 70000000 && amount > 320000) {
        amount = 320000;
        msg99 = "Congarts";
      } else if (amount > 10000 && amount < 320000) {
        amount = 10000;
        msg99 = "Congarts";
      } else if (amount < 10000) {
        amount = 0;
        msg99 = "Try Again!!";
      }
    }
    super.initState();
  }

  getCurrentTime() {
    currTime =
        "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}";
    currDate = "${DateTime.now().toIso8601String().substring(0, 10)}";
    setState(() {});
  }

  initUser() async {
    user = await FirebaseAuth.instance.currentUser();
    print(user.displayName);
    await fb.collection("KBCResults").add({
      "Name": user != null ? user.displayName : Text("Unknown"),
      "Amount": amount,
      "Time": currTime,
      "Date": currDate,
      "Email": user.email
    }).then((value) =>
        print(value.documentID + " Saved Succesfully to KBCResults"));
    assert(user != null);
    print("yessssss");
    print(user.phoneNumber);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kaun Banega Crorepati"),
          // backgroundColor: Colors.black26,
          centerTitle: true,
        ),
        backgroundColor: Colors.deepPurple[100],
        body: FutureBuilder(
            future: null,
            builder: (BuildContext context, fetch) {
              if (fetch.connectionState == ConnectionState.none &&
                  fetch.hasData == null) {
                //print('project snapshot data is: ${projectSnap.data}');
                return Container();
              }
              return ListView.builder(
                  itemCount: finalQues.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Material(
                            color: Colors.indigoAccent,
                            elevation: 6.0,
                            borderRadius: BorderRadius.circular(30.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CustomButtonOpt(
                                    opt: (index + 1).toString() +
                                        ". " +
                                        finalQues[index],
                                  ),
                                  CustomButtonOpt(
                                    opt: "A. " + finalOpt1[index],
                                  ),
                                  CustomButtonOpt(
                                    opt: "B. " + finalOpt2[index],
                                  ),
                                  CustomButtonOpt(
                                    opt: "C. " + finalOpt3[index],
                                  ),
                                  CustomButtonOpt(
                                    opt: "D. " + finalOpt4[index],
                                  ),
                                  CustomButtonOpt(
                                    opt: "Ans: " + finalAns[index],
                                  ),
                                  index == finalQues.length - 1
                                      ? PlayAgain(
                                          amount: amount,
                                          quesAttempted: quesAttempted,
                                          imgPath: user.photoUrl,
                                        )
                                      : Text(""),
                                
                                ],
                              ),
                            )),
                      ),
                    );
                  });
            }));
  }
}

class PlayAgain extends StatelessWidget {
  final amount, quesAttempted;
  final String imgPath;
  PlayAgain({this.amount, this.quesAttempted, this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
      color: Colors.green[200],
      elevation: 8.0,
      borderRadius: BorderRadius.circular(18.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            imgPath != null? ClipOval(child: Image.network(imgPath,fit: BoxFit.fill,),): Icon(Icons.person),
            Text(
              "Total Amount: ₹ $amount",
              textScaleFactor: 2,
            ),
            Text("Questions Attempted: $quesAttempted", textScaleFactor: 2),
            CustomButton(
              text: "Play Again",
              callback: () => Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new LetsPlay())),
            )
          ],
        ),
      ),
    ));
  }
}
