
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;

  const CustomButton({Key key, this.callback, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.indigo,
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200.0,
          height: 45.0,
          child: Text(text,textScaleFactor: 1.7,style: TextStyle(color:Colors.white),),
        ),
      ),
    );
  }
}

class CustomButtonOpt extends StatelessWidget {
  final String opt;
  CustomButtonOpt({this.opt});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.indigo,
        elevation: 6.0,
        borderRadius: BorderRadius.circular(18.0),
        child: MaterialButton(
          onPressed: null,
          minWidth: 200.0,
          height: 45.0,
          child: Text(opt,textScaleFactor: 1.7,style: TextStyle(color:Colors.white),),
        ),
      ),
    );
  }
}

class OptionsButton extends StatelessWidget {
  final optNo;
  final option;
  OptionsButton({this.optNo,this.option});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo,
      elevation: 16.0,
      borderRadius: BorderRadius.circular(8.0),
      child: Wrap(
        children: <Widget>[
          MaterialButton(onPressed: null,child: Text(optNo+option,textScaleFactor: 1.9,style: TextStyle(color:Colors.white,),)),
        ],
      ),
    );
  }
}