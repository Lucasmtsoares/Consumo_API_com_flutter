import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController txtcep = TextEditingController();
  String resultado = "";

  _consultarCep() async{
    String cep = txtcep.text;
    String url = "https://viacep.com.br/ws/${cep}/json/";
    
    http.Response response;
    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);
    String uf = retorno["uf"];
    String cidade  = retorno["localidade"];
    
    
    setState(() {
      resultado = "${uf}, ${cidade}";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultar CEP'),
        backgroundColor: Color.fromARGB(255, 28, 55, 191),
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
              TextField(
              keyboardType: TextInputType.number,
              controller: txtcep,
            ),
            Text('Resultado: ${resultado}', style: const TextStyle(fontSize: 25)),

            ElevatedButton(
             onPressed: _consultarCep,
             child: const Text("Consultar", style: TextStyle(fontSize: 25))),
             

          ]
        )
      )
    );
  }
}