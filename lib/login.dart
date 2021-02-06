import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  String loginMessage = "";

  void fazerLogin() {
    if (loginController.text == 'Leonardo' && senhaController.text == '201721275') {
      // print('Login efetuado com sucesso');
      setState(() {
        loginMessage = '';
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home())
      );
    } else {
      // print('Falha ao entrar: login ou senha incorretos.');
      setState(() {
        loginMessage = 'Login ou senha incorretos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget> [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Login:',
                hintText: 'Insira o número do imóvel',
                border: OutlineInputBorder()
              ),
              controller: loginController,
            ),
            Divider(),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha:',
                hintText: 'Insira a sua senha',
                border: OutlineInputBorder()
              ),
              keyboardType: TextInputType.number,
              controller: senhaController,
            ),
            Divider(),
            RaisedButton(
              onPressed: () {
                fazerLogin();
              },
              child: Text('Entrar')
            ),
            Text(
              loginMessage, 
              style: TextStyle(fontSize: 14, color: Colors.redAccent),
            ),
          ],
        )
      )
    );
  }
}