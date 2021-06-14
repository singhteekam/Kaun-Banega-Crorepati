import 'package:KBC/data.dart';
import 'package:flutter/material.dart';

class AmountDrawer extends StatefulWidget {
  final int drawerQues;
  AmountDrawer({this.drawerQues});
  @override
  _AmountDrawerState createState() => _AmountDrawerState(drawerQues: drawerQues);
}

class _AmountDrawerState extends State<AmountDrawer> {
  final int drawerQues;
  _AmountDrawerState({this.drawerQues});
  int ansAmt,q;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 16,
      itemBuilder: (context, index) {
          q=index+1;
          ansAmt=amount[index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            color: drawerQues==index+1?Colors.green:index==4||index==8?Colors.yellow[200]:index==15?Colors.red[200]:Colors.blueGrey[200],
            child: ListTile(
              trailing: index==13?Text("₹ 1 Crore",textScaleFactor: 2,):
              index==14?Text("₹ 3 Crores",textScaleFactor: 2,):
              index==15?Text("₹ 7 Crores",textScaleFactor: 2,):
              Text("₹ $ansAmt",textScaleFactor: 2,),
              leading: Text("$q",textScaleFactor: 2,style: TextStyle(fontWeight:FontWeight.bold),),
              title:drawerQues==index+1?Icon(Icons.chevron_right,):Text(" "),
            ),
          ),
        );
      },
    );
  }
}
