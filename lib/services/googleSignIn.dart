
import 'package:KBC/ui/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

  final FirebaseAuth _auth=FirebaseAuth.instance;
  final GoogleSignIn googleSignIn=new GoogleSignIn();

  Future<FirebaseUser> _signIn() async{
    GoogleSignInAccount googleUser= await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  final FirebaseUser user= (await _auth.signInWithCredential(credential)) as FirebaseUser;

  return user;
  }

class KBCGoogleSignIn extends StatefulWidget {
  @override
  _KBCGoogleSignInState createState() => _KBCGoogleSignInState();
}

class _KBCGoogleSignInState extends State<KBCGoogleSignIn> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        Image.network("https://th.thgim.com/entertainment/99oele/article31516935.ece/alternates/FREE_435/PTI8282018000180B"),
        Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SignInButton(
                      Buttons.GoogleDark,
                      // text: "Sign In with Google",
                       onPressed: ()=>_signIn().whenComplete(() => Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => LetsPlay()))),),
                  )
                ]),
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
}