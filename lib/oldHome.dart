// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:prova_2/model/imovel.dart';

import 'dao/imovelDao.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController tipoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController nomeRuaController = TextEditingController();
  TextEditingController areaTotalController = TextEditingController();
  TextEditingController precoController = TextEditingController();

  ImovelDao _db = ImovelDao();

  void cadastrarImovel() {
    setState(() async {
      Imovel imovel = Imovel(
        tipoController.text,
        int.parse(numeroController.text),
        nomeRuaController.text,
        double.parse(areaTotalController.text),
        double.parse(precoController.text)
      );

      int results = await _db.inserirImovel(imovel);
      if (results != null) {
        print('Imóvel cadastrado com sucesso.');
      } else {
        print('Falha ao cadastrar imóvel.');
      }
    });
  }

  List<Imovel> listaDeImoveis = List<Imovel>();

  void listarImoveis() async {
    List listImoveis = await _db.listarImoveis();
    // print('Imoveis cadastrados: ' + listImoveis.toString());
    List<Imovel> lista = List<Imovel>();
    for(var item in listImoveis) {
      Imovel i = Imovel.convertMAPToObject(item);
      lista.add(i);
    }

    setState(() {
      listaDeImoveis = lista;
    });
  }

  void imovelRegisterPage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Cadastrar imóvel"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Número:',
                  hintText: 'Insira o número do imóvel',
                ),
                controller: numeroController,
              ),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Endereço:',
                  hintText: 'Insira o nome da rua do imóvel',
                ),
                controller: nomeRuaController,
              ),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Área:',
                  hintText: 'Insira a área total do imóvel',
                ),
                controller: areaTotalController,
              ),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Preço:',
                  hintText: 'Insira o preço do imóvel',
                ),
                controller: precoController,
              )

            ],
          ),
          actions: [
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Cadastrar"),
              onPressed: () {
                cadastrarImovel();
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // listarImoveis();
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciador de imóveis')
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listaDeImoveis.length,
              itemBuilder: (context, index) {
                final Imovel imovel = listaDeImoveis[index];
                return Card(
                  child: ListTile(
                    title: Text(imovel.tipo + ' - ' + imovel.areatotal.toString() + 'm²'),
                    subtitle: Text('Rua: ' + imovel.nomerua + ' nº ' + imovel.numero.toString() + '\nPreço: RS' + imovel.preco.toString()),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          imovelRegisterPage();
        },
        child: Icon(Icons.add)
      ),

    );
  }
}

