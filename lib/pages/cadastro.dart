import 'package:flutter/material.dart';
import 'package:prova_2/model/imovel.dart';
import '../dao/imovelDao.dart';

class Cadastro extends StatefulWidget {
  @override
  CadastroState createState() => CadastroState();
}

class CadastroState extends State<Cadastro> {
  TextEditingController tipoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController nomeRuaController = TextEditingController();
  TextEditingController areaTotalController = TextEditingController();
  TextEditingController precoController = TextEditingController();

  ImovelDao _db = ImovelDao();
  String mensagemCadastro = '';

  void cadastrarImovel() {
    if (
      (
        tipoController.text != 'casa' && 
        tipoController.text != 'terreno' && 
        tipoController.text != 'apartamento'
      ) ||
      numeroController.text == '' ||
      nomeRuaController.text == '' ||
      areaTotalController.text == '' ||
      precoController.text == ''
      ) {
      setState(() {
        mensagemCadastro = 'Você precisa preencher todos os campos para cadastrar!';
      });
    } else {
      setState(() async {
        mensagemCadastro = '';

        Imovel imovel = Imovel(
          tipoController.text,
          int.parse(numeroController.text),
          nomeRuaController.text,
          int.parse(areaTotalController.text),
          double.parse(precoController.text)
        );

        int results = await _db.inserirImovel(imovel);
        if (results != null) {
          print('Imóvel cadastrado com sucesso.');
          Navigator.pop(context);
        } else {
          mensagemCadastro = 'Falha ao cadastrar imóvel';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar imóvel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget> [
            Divider(),
            Text(
              '* Tipo deve ser: casa, terreno ou apartamento', 
              style: TextStyle(fontSize: 14, color: Colors.redAccent),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tipo:',
                hintText: 'Insira o número do imóvel',
                border: OutlineInputBorder()
              ),
              controller: tipoController,
            ),
            Divider(),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Número:',
                hintText: 'Insira o número do imóvel',
                border: OutlineInputBorder()
              ),
              controller: numeroController,
            ),
            Divider(),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Endereço:',
                hintText: 'Insira o nome da rua do imóvel',
                border: OutlineInputBorder()
              ),
              controller: nomeRuaController,
            ),
          Divider(),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Área:',
                hintText: 'Insira a área total do imóvel',
                border: OutlineInputBorder()
              ),
              controller: areaTotalController,
            ),
            Divider(),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Preço:',
                hintText: 'Insira o preço do imóvel',
                border: OutlineInputBorder()
              ),
              controller: precoController,
            ),
            Divider(),
            RaisedButton(
              onPressed: () {
                cadastrarImovel();
              },
              child: Text('Cadastrar')
            ),
            Text(
              mensagemCadastro, 
              style: TextStyle(fontSize: 14, color: Colors.redAccent),
            ),
          ],
        )
      )
    );
  }
}