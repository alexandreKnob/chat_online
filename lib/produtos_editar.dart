import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProdutosEditar extends StatefulWidget  {

  final String tipoEdicao;
  final DocumentSnapshot dadosProduto;


  ProdutosEditar(this.tipoEdicao,this.dadosProduto);

  @override
  _ProdutosEditarState createState() => _ProdutosEditarState();
}


class _ProdutosEditarState extends State<ProdutosEditar> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DocumentSnapshot dadosProduto;
  String nome = "" ;
  String teste = "";
  TextEditingController campoNome = TextEditingController();
  TextEditingController campoValor = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.tipoEdicao=="alt"){
      campoNome.text =   widget.dadosProduto.data["nome"].toString();
      campoValor.text =   widget.dadosProduto.data["valor"].toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tipoEdicao=="inc" ? "Inclusão de Produtos" : "Alteração de Produtos" ),
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
                            if (widget.tipoEdicao=="inc") {
                              Firestore.instance.collection("produtos").add(
                                  {
                                    "nome" : campoNome.text,
                                    "valor" : campoValor.text
                                  }
                              );
                            } else {
                              Firestore.instance.collection("produtos").document(widget.dadosProduto.documentID).updateData({
                                "nome" : campoNome.text,
                                "valor" : campoValor.text
                              });
                              Navigator.pop(context);
                            }


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

