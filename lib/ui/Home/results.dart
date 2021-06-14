import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {

  final firestore= Firestore.instance;
  List<int> fetchAmt=[];
  List<String> fetchName=[],fetchDate=[],fetchTime=[];

  @override
  void initState() {
    super.initState();
    getResults();
  }

  getResults() async{
    await firestore.collection("KBCResults").getDocuments().then((fetchData) {
      fetchData.documents.forEach((fetchData){
        fetchAmt.add(fetchData.data['Amount']);
        fetchName.add(fetchData.data['Name']);
        fetchDate.add(fetchData.data['Date']);
        fetchTime.add(fetchData.data['Time']);
      setState(() {});
      });
      print(fetchAmt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("All Results")
      ),
      body: FutureBuilder(
    builder: (context, fetchSnap) {
      if (fetchSnap.connectionState == ConnectionState.none &&
          fetchSnap.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
      return ListView.builder(
        itemCount: fetchName.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color:Colors.purple[200],
                borderRadius: BorderRadius.circular(20)
              ),
              child: ListTile(
                title: Text(fetchName[index],textScaleFactor: 1.5,style: TextStyle(fontWeight:FontWeight.bold,fontStyle:FontStyle.italic),),
                trailing: Text("₹ "+fetchAmt[index].toString(),textScaleFactor: 1.5,style: TextStyle(fontWeight:FontWeight.bold,)),
                subtitle: Column(
                  children:<Widget>[
                    Text("Time: "+fetchTime[index],style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black)),
                    Text("Date: "+fetchDate[index],style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black)),
                  ]
                ),
              ),
            ),
          );
        },
      );
    },
    future: null,
    )
    );
  }
}