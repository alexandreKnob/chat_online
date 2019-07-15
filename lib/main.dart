import 'package:flutter/material.dart';

import 'produtos.dart';

void main() {
  /* Firestore.instance.collection("usuarios").snapshots().listen((snapshot) {

    for (DocumentSnapshot doc in snapshot.documents) {
      print(doc.data);
    }

  });
*/
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste Google FireStore "),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: FlatButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Produtos()));
                },
                child: Text( "Firestore com Páginas",style: TextStyle(color: Colors.white),)
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: FlatButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Produtos()));
                },
                child: Text("Firestore com Alert", style: TextStyle(color: Colors.white), )
            ),
          ),
        ],
      ),
    );
  }
}
