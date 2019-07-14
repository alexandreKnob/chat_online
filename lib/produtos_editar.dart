import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProdutosEditar extends StatefulWidget  {

  String produtoID;



  ProdutosEditar(this.produtoID);

  @override
  _ProdutosEditarState createState() => _ProdutosEditarState();
}


class _ProdutosEditarState extends State<ProdutosEditar> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DocumentSnapshot dadosProduto;
  String nome = "" ;

  TextEditingController campoNome = TextEditingController();
  TextEditingController campoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inclusão de Produtos"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left:10,right: 10),

        child:
          Form(
            key: _formKey,
            child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30),
                child:Icon(Icons.add_shopping_cart,color: Colors.blueAccent,size: 70,) ,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 18)),
                textAlign: TextAlign.left,
                controller: campoNome,
                validator: (value){
                  if (value.isEmpty){
                    return "Informe o Nome!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Valor do Produto",
                    labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 18)),
                textAlign: TextAlign.left,
                controller: campoValor,
                validator: (value){
                  if (value.isEmpty){
                    return "Informe o Valor!";
                  }
                },
              ), // aqui
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: FlatButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()){
                            Firestore.instance.collection("produtos").add(
                                {
                                  "nome" : campoNome.text,
                                 "valor" : campoValor.text
                                }
                            );
                            Navigator.pop(context);
                          }

                        },
                        color: Colors.blue,
                        child: Text("Gravar",textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: FlatButton(
                        onPressed: () {Navigator.pop(context); },
                        color: Colors.blue,
                        child: Text("Cancelar",textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
                    ),
                  ),
                ],
              ),
            ],
            ),
          ),
      ),
    );
  }




}

