
import 'dart:io';

import 'package:KBC/ad_helper.dart';
import 'package:KBC/widgets/customButton.dart';
import 'package:KBC/services/googleSignIn.dart';
import 'package:KBC/ui/game_screen.dart';
import 'package:KBC/ui/Home/instructions.dart';
import 'package:KBC/ui/Home/myResults.dart';
import 'package:KBC/ui/Home/results.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class LetsPlay extends StatefulWidget {
  @override
  _LetsPlayState createState() => _LetsPlayState();
}

class _LetsPlayState extends State<LetsPlay> {

final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  final firestoreInstance = FirebaseFirestore.instance;
  List<String> questions=[],option1=[],option2=[],option3=[],option4=[],answers=[],fOp1=[],fOp2=[],fOp3=[],fOp4=[];
  List<int> aOp1=[],aOp2=[],aOp3=[],aOp4=[];

  // BannerAd _ad;
  // bool isLoaded;
  
  @override
  void initState() {
    getAllQuestions();
    initUser();
    super.initState();

    // _ad= BannerAd(
    //   adUnitId: AdHelper.bannerAdUnitId,
    //   request: AdRequest(),
    //   size: AdSize.banner,
    //   listener: AdListener(
    //     onAdLoaded: (_){
    //       setState((){
    //         isLoaded= true;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, error) => print("Add failed to load"),
    //   )
    // );

    // _ad.load();
  }

  

   getAllQuestions() async{
    // questions=[]; option1=[]; option2=[]; option3=[]; option4=[]; answers=[]; fOp1=[]; fOp2=[]; fOp3=[]; fOp4=[]; aOp1=[]; aOp2=[]; aOp3=[]; aOp4=[];
     await firestoreInstance.collection("KBC").getDocuments().then((querySnapshot) {
       var queryData=querySnapshot.documents;
       queryData.shuffle();
      queryData.forEach((result) {
      questions.add(result.data['question']);
      option1.add(result.data['option1']);
      option2.add(result.data['option2']);
      option3.add(result.data['option3']);
      option4.add(result.data['option4']);
      answers.add(result.data['answer']);
      fOp1.add(result.data['ff1']);
      fOp2.add(result.data['ff2']);
      fOp3.add(result.data['ff3']);
      fOp4.add(result.data['ff4']);
      aOp1.add(result.data['ap1']);
      aOp2.add(result.data['ap2']);
      aOp3.add(result.data['ap3']);
      aOp4.add(result.data['ap4']);  
      // print(result.data['answer']);
      
    setState(() {});
    });
    // print(option4);
  });
  // print(answers);
  // print(option1);
  }
  

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  signOut() async{
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    print("User Signed Out");
  }

  // @override
  // void dispose(){
  //   _ad?.dispose();
  //   super.dispose();
  // }

  // displayAd(){
  //   if(isLoaded== true){
  //     return Container(
  //       child: AdWidget(ad: _ad),
  //       alignment: Alignment.center,

  //     );
  //   }
  //   else {
  //     return CircularProgressIndicator();
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user==null?Center(child: CircularProgressIndicator()):ListView(children: <Widget>[
        // Image.network("https://th.thgim.com/entertainment/99oele/article31516935.ece/alternates/FREE_435/PTI8282018000180B"),
        Image.asset("assets/ab_img.jpg"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child:Text("Hi "+"${user.displayName.substring(0,user.displayName.indexOf(" "))}",textScaleFactor: 2,style: TextStyle(color:Colors.white,backgroundColor: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                    ),
                  ),
                  // RaisedButton(
                  //   onPressed: () { 
                  //     Navigator.pushReplacement(
                  //       context,
                  //       new MaterialPageRoute(
                  //           builder: (BuildContext context) => MyHomePage(questions: questions,option1: option1,option2: option2,option3: option3,option4: option4,answers: answers,fOp1: fOp1,fOp2: fOp2,fOp3: fOp3,fOp4: fOp4,aOp1: aOp1,aOp2: aOp2,aOp3: aOp3,aOp4: aOp4)));
                  //   },
                  //   color: Colors.green,
                  //   child: Text(
                  //     "Play",
                  //     textScaleFactor: 2,
                  //   ),
                  // ),
                  CustomButton(
                    text: "Play",
                    callback: ()=>Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => MyHomePage(questions: questions,option1: option1,option2: option2,option3: option3,option4: option4,answers: answers,fOp1: fOp1,fOp2: fOp2,fOp3: fOp3,fOp4: fOp4,aOp1: aOp1,aOp2: aOp2,aOp3: aOp3,aOp4: aOp4))),
                  ),
                  CustomButton(
                    text: "Instructions",
                    callback: instructions,
                  ),
                  CustomButton(
                    text: "My Results",
                    callback: ()=>Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => MyResults())),
                  ),
                  CustomButton(
                    text: "All Results",
                    callback:  ()=> Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => Results())),
                  ),
                  CustomButton(
                    text: "Sign Out",
                    callback: (){ 
                      signOut();
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => KBCGoogleSignIn()));
                    },
                  ),
                  CustomButton(
                    text: "Exit",
                    callback: () => exit(0),
                  ),

                  // displayAd(),
                  
                ]),
          ],
        ),
      ]),
      backgroundColor: Colors.lightBlue[200],
      bottomNavigationBar: Text(
            "BUILT BY @Teekam Singh❤️",
            textAlign: TextAlign.center,
            textScaleFactor: 1.5,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }

  void instructions(){
    showDialog(context: context,
    builder: (context) {
      return Instructions();
    },
    );
  }
}
