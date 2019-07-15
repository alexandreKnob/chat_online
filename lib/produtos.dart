import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'produtos_editar.dart';

class Produtos extends StatefulWidget {
  @override
  _ProdutosState createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  DocumentSnapshot branco;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Produtos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProdutosEditar("inc",branco)));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: Firestore.instance.collection("produtos").orderBy("nome").snapshots(),
                builder: (context, snapshot) {
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return Card( // Lista os clientes
                                child: ListTile(
                                  //snapshot.data.documents[index].documentID.toString() - pega o ID
                                  title: Text(snapshot.data.documents[index].data["nome"], style: TextStyle(fontSize: 25)),
                                  subtitle: Text("R\$ "  + snapshot.data.documents[index].data["valor"].toString(),style: TextStyle(fontSize: 20)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        color: Colors.black,
                                        onPressed: () {
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ProdutosEditar(snapshot.data.documents[index].documentID.toString())));
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProdutosEditar("alt",snapshot.data.documents[index])));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        color: Colors.black,
                                        onPressed: () {
                                          _confirmaExclusao(context, index, snapshot);
                                        },
                                      ),
                                    ],
                                  ),
                                ));
                          }
                      );
                  }
                }
            ),
          )
        ],
      ),
    );
  }

  _confirmaExclusao(BuildContext context, index, snapshot) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Nome : " + snapshot.data.documents[index].data["nome"]),
          content:
          Text("Confirma a exclusão do " + snapshot.data.documents[index].data["nome"]),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Firestore.instance.collection('produtos')
                    .document(snapshot.data.documents[index].documentID.toString())
                    .delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
