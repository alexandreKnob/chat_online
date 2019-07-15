import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController campoPeso = TextEditingController();
  TextEditingController campoAltura = TextEditingController();

  Color corTexto = Colors.red;
  String textoInfo = "Informe seus dados !";

  void _resseta(){
    campoPeso.text = "";
    campoAltura.text = "";
    setState(() {
      textoInfo = "Informe seus dados !";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcula(){
    double peso = double.parse(campoPeso.text);
    double altura = double.parse(campoAltura.text)/100;
    double imc = peso / (altura * altura);

    setState(() {
      if(imc < 18.6){
        textoInfo = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.6 && imc < 24.9){
        textoInfo = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        textoInfo = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        textoInfo = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        textoInfo = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
        corTexto = Colors.yellow;
      } else if(imc >= 40){
        textoInfo = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cálculo do Imc",
          style: TextStyle(color: Colors.yellow),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh, color: Colors.yellow),
              onPressed: _resseta)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.people_outline,color: Colors.green,size: 120,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green, fontSize: 24)),
                  textAlign: TextAlign.center,
                  controller: campoPeso,
                  validator: (value){
                    if (value.isEmpty){
                      return "Informe o Peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (Cm)",
                      labelStyle: TextStyle(color: Colors.green, fontSize: 24)),
                  textAlign: TextAlign.center,
                  controller: campoAltura,
                  validator: (value){
                    if (value.isEmpty){
                      return "Informe a Altura!";
                    }
                  },
                ),
                Container( //
                  padding: EdgeInsets.fromLTRB(20, 0.0, 20, 0.0),
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  height: 50,
                  child: RaisedButton(
                    textColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState.validate()){
                        _calcula();
                      }
                    },
                    child: Text("Calcular",style: TextStyle(color: Colors.white, fontSize: 25),),
                    color: Colors.green,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(textoInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: corTexto,fontSize: 25),),
                )

              ],
            ),
          )
      ),
    );
  }



}
