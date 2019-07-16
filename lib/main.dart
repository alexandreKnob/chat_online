import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

final googleSignIn = GoogleSignIn();
final auth = FirebaseAuth.instance;

 String nomeUsuario="";
 String emailUsuario="";
 String fotoUsuario="";



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
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 40,
                  backgroundImage:  NetworkImage(fotoUsuario,scale: 1),
                ),
                Text(nomeUsuario.toString() ),
                Text(emailUsuario.toString() ),

              ],
            ),
          ),
          Container(

            padding: EdgeInsets.all(10),
            child: FlatButton(
                color: Colors.blueAccent,
                onPressed: () async {
                  await _ensureLoggedIn();
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

  @override
  void initState()  {
    super.initState();
    _ensureLoggedIn();
    setState(() {

    });
  }

  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if(user == null)
      user = await googleSignIn.signInSilently();
    if(user == null)
      user = await googleSignIn.signIn();
    if(await auth.currentUser() == null){
      GoogleSignInAuthentication credentials = await googleSignIn.currentUser.authentication;
      await auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: credentials.idToken, accessToken: credentials.accessToken));
    }

    setState(() {
      nomeUsuario = user.displayName.toString();
      emailUsuario = user.email.toString();
      fotoUsuario = user.photoUrl.toString();
    });


  }

}
