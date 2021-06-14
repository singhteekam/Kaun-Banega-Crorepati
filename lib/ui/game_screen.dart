import 'dart:async';
import 'dart:math';
import 'package:KBC/data.dart';
import 'package:KBC/ui/Lifelines/PAF.dart';
import 'package:KBC/ui/Lifelines/audiencePoll.dart';
import 'package:KBC/ui/finalPage.dart';
import 'package:KBC/ui/Home/instructions.dart';
import 'package:KBC/widgets/amountDrawer.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class MyHomePage extends StatefulWidget {
  final questions,option1,option2,option3,option4,answers,fOp1,fOp2,fOp3,fOp4;
  final aOp1,aOp2,aOp3,aOp4;
  MyHomePage({this.questions,this.option1,this.option2,this.option3,this.option4,this.answers,this.fOp1,this.fOp2,this.fOp3,this.fOp4,this.aOp1,this.aOp2,this.aOp3,this.aOp4});
  @override
  _MyHomePageState createState() => _MyHomePageState(questions: questions,option1: option1,option2: option2,option3: option3,option4: option4,answers: answers,fOp1: fOp1,fOp2: fOp2,fOp3: fOp3,fOp4: fOp4,aOp1: aOp1,aOp2: aOp2,aOp3: aOp3,aOp4: aOp4);
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> questions,option1,option2,option3,option4,answers,fOp1,fOp2,fOp3,fOp4;
  List<int> aOp1,aOp2,aOp3,aOp4;
  _MyHomePageState({this.questions,this.option1,this.option2,this.option3,this.option4,this.answers,this.fOp1,this.fOp2,this.fOp3,this.fOp4,this.aOp1,this.aOp2,this.aOp3,this.aOp4});
  

  static AudioPlayer audioPlayer=new AudioPlayer();
  AudioCache audioCache=new AudioCache(fixedPlayer: audioPlayer);
  VoiceController _voiceController;
  String text ='';
  
  List<String> finalQues=[],finalOpt1=[],finalOpt2=[],finalOpt3=[],finalOpt4=[],finalAns=[];
  String msg = "",wRongAns="";
  int index=0,qNo=1,totalAmount=0,clock=45,attemptedQues=0,z;
  Color correctOrwrongColor;
  List<Color> optColor=[Colors.lightBlue[200],Colors.lightBlue[200],Colors.lightBlue[200],Colors.lightBlue[200]];
  bool aP=false,ff=false,paf=false,ftq=false, ftqUsed=false,ffUsed=false;

  @override
  initState(){
    print(questions.length);
    // questions=shuffle(questions);
    audioCache.play("KbcNewQues.mp3");
    clockTime();
    Timer(Duration(seconds: 2),initial);
    super.initState();
  }


  initial(){
    setState(() {
    text=questions[0]+"? Option A: "+option1[0]+"? Option B: "+option2[0]+"? Option C: "+option3[0]+"? Option D:"+option4[0];
  });
     _voiceController = FlutterTextToSpeech.instance.voiceController();
     _voiceController.init().then((_) {_voiceController.speak(text,VoiceControllerOptions(speechRate: 0.8),);});
      audioCache.play("KbcClock.mp3");
  }

  playAudio()=>_voiceController.init().then((_) {_voiceController.speak(text,VoiceControllerOptions(speechRate: 0.8,),);});

  List shuffle(List questions) {
  var random = new Random();
  for (var i = questions.length - 2; i > 0; i--) {
    var n = random.nextInt(i + 1);

    var temp = questions[i];
    questions[i] = questions[n];
    questions[n] = temp;

    var temp2=option1[i];
    option1[i]=option1[n];
    option1[n]=temp2;

    var temp3=option2[i];
    option2[i]=option2[n];
    option2[n]=temp3;

    var temp4=option3[i];
    option3[i]=option3[n];
    option3[n]=temp4;

    var temp5=option4[i];
    option4[i]=option4[n];
    option4[n]=temp5;

    var temp6=answers[i];
    answers[i]=answers[n];
    answers[n]=temp6;

    var temp7=aOp1[i]; aOp1[i]=aOp1[n]; aOp1[n]=temp7;
    var temp8=aOp2[i]; aOp2[i]=aOp2[n]; aOp2[n]=temp8;
    var temp9=aOp3[i]; aOp3[i]=aOp3[n]; aOp3[n]=temp9;
    var temp10=aOp4[i]; aOp4[i]=aOp4[n]; aOp4[n]=temp10;

    var temp11=fOp1[i]; fOp1[i]=fOp1[n]; fOp1[n]=temp11;
    var temp12=fOp2[i]; fOp2[i]=fOp2[n]; fOp2[n]=temp12;
    var temp13=fOp3[i]; fOp3[i]=fOp3[n]; fOp3[n]=temp13;
    var temp14=fOp4[i]; fOp4[i]=fOp4[n]; fOp4[n]=temp14;
  }
    setState(() {
    text=questions[0]+"? Option A: "+option1[0]+"? Option B: "+option2[0]+"? Option C: "+option3[0]+"? Option D:"+option4[0];
  });
  return questions;
}

  checkAnswerPopUp(String ans, int val,int optNo,String lock){
    showDialog(context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Lock Option $lock?"),
        actions: <Widget>[
        FlatButton(child: Text("No"),
        onPressed: () => Navigator.pop(context),
        ),
        FlatButton(child: Text("Yes"),
        onPressed: () { 
          checkAnswer(ans, val, optNo);
          Navigator.pop(context);
          }),
      ],
      );
    },
    );
  }

  checkAnswer(String ans, int val,int optNo) {
    setState(() {
      if(ff){
       ffUsed=true;
      }
      attemptedQues=1;
      _voiceController.stop();
      if (ans == answers[val]) {
        ff?ff=false:Text("");
        optColor[optNo]=Colors.green;
        correctOrwrongColor=Colors.green;
        msg = "Correct Answer";
        _voiceController.init().then((_) {_voiceController.speak(msg,VoiceControllerOptions(speechRate: 0.8),);});
        finalQues.add(questions[val]);
        finalOpt1.add(option1[val]);
        finalOpt2.add(option2[val]);
        finalOpt3.add(option3[val]);
        finalOpt4.add(option4[val]);
        finalAns.add(answers[val]);
        totalAmount=amount[qNo-1];
        if(qNo<16){
        Timer(Duration(seconds: 2), nextQues);
        }
        else{
          Timer(Duration(seconds: 2), (){
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context)=>new FinalPage(totalAmount,qNo,finalQues,finalOpt1,finalOpt2,finalOpt3,finalOpt4,finalAns,0)));});  
        }
      } else {
        correctOrwrongColor=Colors.red;
        msg="Wrong Answer";
        finalQues.add(questions[index]);
        finalOpt1.add(option1[index]);
        finalOpt2.add(option2[index]);
        finalOpt3.add(option3[index]);
        finalOpt4.add(option4[index]);
        finalAns.add(answers[index]);
        String corr=answers[val];
        wRongAns="$corr";
        optColor[optNo]=Colors.red;
        _voiceController.init().then((_) {_voiceController.speak(msg+"? Correct Answer is $wRongAns",VoiceControllerOptions(speechRate: 0.8),);});
         Timer(Duration(seconds: 4), (){
           Navigator.of(context).popUntil((route) => route.isFirst);
           Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context)=>new FinalPage(totalAmount,qNo,finalQues,finalOpt1,finalOpt2,finalOpt3,finalOpt4,finalAns,0)));});
         
      }
    });
  }

  clockTime(){
     clock=45;
    questions.length==0?Center(child: CircularProgressIndicator()):Timer.periodic(Duration(seconds: 1), (timer) {
      if(!mounted) return;
      setState(() {
        if(attemptedQues==1 || qNo>4)
        timer.cancel();
        if(clock==0){
          msg="Time Up!!";
          _voiceController.init().then((_) {_voiceController.speak(msg,VoiceControllerOptions(speechRate: 0.8),);});
          timer.cancel();
          finalQues.add(questions[index]);
          finalOpt1.add(option1[index]);
          finalOpt2.add(option2[index]);
          finalOpt3.add(option3[index]);
          finalOpt4.add(option4[index]);
          finalAns.add(answers[index]);
          Timer(Duration(seconds: 2), (){
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context)=>new FinalPage(totalAmount,qNo,finalQues,finalOpt1,finalOpt2,finalOpt3,finalOpt4,finalAns,0)));});
        }
        else{ clock--; }
        print("$clock");
      });
     });
  }
  nextQues(){
    setState(() {
      correctOrwrongColor=Colors.green;
      if(ff){
       ffUsed=true;
      }
      ff?ff=false:Text("");
      if(ftq==true && ftqUsed==false){
        qNo--;
      clock=45;
      ftqUsed=true;
      }
      else
     clockTime();
      attemptedQues=0;
      optColor[0]=Colors.lightBlue[200];optColor[1]=Colors.lightBlue[200];optColor[2]=Colors.lightBlue[200];optColor[3]=Colors.lightBlue[200];
      text=questions[ftq?qNo+1:qNo]+"? Option A: "+option1[ftq?qNo+1:qNo]+"? Option B: "+option2[ftq?qNo+1:qNo]+"? Option C: "+option3[ftq?qNo+1:qNo]+"? Option D: "+option4[ftq?qNo+1:qNo];
      qNo=qNo+1;
      index++;
      msg="";
      audioCache.play("KbcNewQues.mp3");
    Timer(Duration(seconds: 4),nextQuesVoice);
    });
  }
  nextQuesVoice(){
    setState(() {
      audioCache.play("KbcClock.mp3");
       _voiceController.init().then((_) {_voiceController.speak(text,VoiceControllerOptions(speechRate: 0.8),);});
    });
  }

  void instructions(){
    showDialog(context: context,
    builder: (context) {
      return Instructions();
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Kaun Banega Crorepati"),centerTitle: true,actions: <Widget>[
          IconButton(icon: Icon(Icons.help), onPressed: instructions)
        ],),
        endDrawer: Drawer( child: AmountDrawer(drawerQues: qNo,),),
        body: questions.length==0?Center(child: CircularProgressIndicator()):Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              qNo<5?CircularPercentIndicator(
                 radius: 60,
                 percent: clock*0.02222,
                 center:Text(
                  "$clock",
                  textScaleFactor: 2,
                  style: TextStyle(
                    color: Colors.indigo
                  ),
                ),
              ):Text(""),
              Container(
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                  child: Text("$qNo."+
                questions[index],
                textScaleFactor: 2,style: TextStyle(color:Colors.white),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    checkAnswerPopUp(option1[index], index,0,'A');
                  },
                  child: Container(
                    decoration: BoxDecoration(color: optColor[0], borderRadius: BorderRadius.circular(10)),
                    child: ff?Text("A. "+fOp1[index],textScaleFactor: 2,):Text("A. " + option1[index], textScaleFactor: 2),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    checkAnswerPopUp(option2[index], index,1,'B');
                  },
                  child: Container(
                    decoration: BoxDecoration(color: optColor[1], borderRadius: BorderRadius.circular(10)),
                    child: ff?Text("B. "+fOp2[index],textScaleFactor: 2,):Text("B. " + option2[index], textScaleFactor: 2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    checkAnswerPopUp(option3[index], index,2,'C');
                  },
                  child: Container(
                    decoration: BoxDecoration(color: optColor[2], borderRadius: BorderRadius.circular(10)),
                    child: ff?Text("C. "+fOp3[index],textScaleFactor: 2,):Text("C. " + option3[index], textScaleFactor: 2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    checkAnswerPopUp(option4[index], index,3,'D');
                  },
                  child: Container(
                    decoration: BoxDecoration(color: optColor[3], borderRadius: BorderRadius.circular(10)),
                    child: ff?Text("D. "+fOp4[index],textScaleFactor: 2,):Text("D. " + option4[index], textScaleFactor: 2),
                  ),
                ),
              ),
              ListTile(
                leading: IconButton(icon: Icon(Icons.record_voice_over,color: Colors.green,), onPressed: playAudio),
                title: FlatButton(color: Colors.red,onPressed: ()=>_quit(),child: Text("Quit",textScaleFactor: 2,style: TextStyle(color:Colors.white),)),
                trailing: IconButton(icon: Icon(Icons.stop,color: Colors.red,), onPressed: ()=>_voiceController.stop()),
              ),
              
              Center(
                child: Text(
                  "$msg",
                  textScaleFactor: 2,
                  style: TextStyle(
                    color: correctOrwrongColor
                  ),
                ),
              ),
              correctOrwrongColor==Colors.red?Center(
                child: Text(
                  "Correct Answer is: $wRongAns",
                  textScaleFactor: 2,
                  style: TextStyle(
                    color: Colors.green
                  ),
                ),
              ):Text(""),
              
              Center(child: Text("Total: ₹ "+"$totalAmount",textScaleFactor: 2,)),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Center(child: Text("Lifelines",textScaleFactor: 2,style: TextStyle(fontWeight:FontWeight.bold,fontStyle:FontStyle.italic,color: Colors.green,decoration: TextDecoration.underline),)),
              ),
              // Lifelines
              Wrap(
                 alignment: WrapAlignment.spaceEvenly,
                  runSpacing: 5,
                  children: <Widget>[
        GestureDetector(
          onTap: (){
            if(aP){
              Fluttertoast.showToast(msg: "You don't have Audience Poll lifeline");
            }
            else{
              setState(() {
              aP=true;
              _audiencePoll();
              });
            }
          },
            child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            child: Center(child: Image.asset("assets/lifelines/AudPoll.png")),
          ),
        ),
         GestureDetector(
          onTap: (){
            if(ffUsed){
              Fluttertoast.showToast(msg: "You don't have 50-50 lifeline");
            }
            else{
              setState(() {
              ff=true;
              
              });
            }
          },
            child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            child: Center(child: Image.asset("assets/lifelines/50fifty.png")),
          ),
        ),
         GestureDetector(
          onTap: (){
            if(paf){
              Fluttertoast.showToast(msg: "You don't have Phone a Friend lifeline");
            }
            else{
              setState(() {
              paf=true;
              _phoneAFriend();
              });
            }
          },
            child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            child: Center(child: Image.asset("assets/lifelines/PAF_LL.png")),
          ),
        ),
         GestureDetector(
          onTap: (){
            if(ftq){
              Fluttertoast.showToast(msg: "You don't have Flip the question lifeline");
            }
            else{
              setState(() {
              ftq=true;
              _voiceController.stop();
              correctOrwrongColor=Colors.red;
              wRongAns=answers[index];
              _voiceController.init().then((_) {_voiceController.speak("Correct Answer is: ?"+wRongAns,VoiceControllerOptions(speechRate: 0.8),);});
              Timer(Duration(seconds: 4), nextQues);
              // nextQues();
              });
            }
          },
            child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            child: Center(child: Image.asset("assets/lifelines/flip.png")),
          ),
        ),
      ],
    )
            ],
          ),
        ),
        backgroundColor: Colors.deepPurple[100],
        );
  }
  void _audiencePoll(){
    showDialog(context: context,
    builder: (BuildContext context){
      return AudiencePoll(op1: aOp1[index],op2: aOp2[index],op3: aOp3[index],op4: aOp4[index],);
    }
    );
  }

  void _phoneAFriend(){
    showDialog(context: context,
    builder: (BuildContext context){
      return PhoneAFriend(ques: questions[index],opt1: option1[index],opt2: option2[index],opt3: option3[index],opt4: option4[index],answ: answers[index],);
    });
  }

  void _quit(){
    showDialog(context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Do you really want to Quit?"),
        content: Text("Current Amount : ₹ $totalAmount"),
        actions: <Widget>[
          FlatButton(child: Text("No"),
        onPressed: () => Navigator.pop(context),),
        FlatButton(child: Text("Yes"),
        onPressed: () { 
          if(!mounted) return;
          setState(() {
          finalQues.add(questions[index]);
          finalOpt1.add(option1[index]);
          finalOpt2.add(option2[index]);
          finalOpt3.add(option3[index]);
          finalOpt4.add(option4[index]);
          finalAns.add(answers[index]);
            _voiceController.stop();
            _voiceController.stop();
            audioPlayer.stop();
          });
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context)=>new FinalPage(totalAmount,qNo,finalQues,finalOpt1,finalOpt2,finalOpt3,finalOpt4,finalAns,1)));
        }),
      ],);
    },
    );
  }
}
