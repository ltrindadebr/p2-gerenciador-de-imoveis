import 'package:flutter/material.dart';
import 'pages/cadastro.dart';
import 'pages/listar.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  void fazerLogin() {
    
  }
  void cadastrarImovel() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Cadastro())
    );
  }
  void listarImoveis(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Listar())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciador de imóveis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget> [
            Divider(),
            RaisedButton(
              onPressed: () {
                cadastrarImovel();
              },
              child: Text('Cadastrar imóvel')
            ),
            RaisedButton(
              onPressed: () {
                listarImoveis();
              },
              child: Text('Listar imóveis')
            ),
            RaisedButton(
              onPressed: () {
                fazerLogin();
              },
              child: Text('Editar imóveis')
            ),
            RaisedButton(
              onPressed: () {
                fazerLogin();
              },
              child: Text('Excluir imóveis')
            ),
            Divider(),
          ],
        )
      )
    );
  }
}