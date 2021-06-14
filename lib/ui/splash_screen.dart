import 'dart:async';

import 'package:KBC/services/googleSignIn.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  static AudioPlayer audioPlayer = new AudioPlayer();
  AudioCache audioCache = new AudioCache(fixedPlayer: audioPlayer);

  @override
  void initState() {
    audioCache.play("KbcTheme.mp3");
    Timer(
        Duration(seconds: 6),
        () => Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => KBCGoogleSignIn())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Image.asset("assets/KbcSplashScreen.jpg")));
  }
}


