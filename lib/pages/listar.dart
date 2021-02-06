import 'package:flutter/material.dart';
import 'package:prova_2/model/imovel.dart';
import '../dao/imovelDao.dart';

class Listar extends StatefulWidget {
  @override
  ListarState createState() => ListarState();
}

class ListarState extends State<Listar> {
  ImovelDao _db = ImovelDao();

  List<Imovel> listaDeImoveis = List<Imovel>();

  void listarImoveis() async {
    List listImoveis = await _db.listarImoveis();
    List<Imovel> lista = List<Imovel>();
    for(var item in listImoveis) {
      Imovel i = Imovel.convertMAPToObject(item);
      lista.add(i);
    }

    setState(() {
      listaDeImoveis = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    listarImoveis();
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de imóveis'),
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
                    title: Text('Tipo: ' + imovel.tipo),
                    subtitle: Text(
                      'Rua: ' + imovel.nomerua + 
                      '\nArea: ' + imovel.areatotal.toString() + 'm²' +
                      '\nNúmero: ' + imovel.numero.toString() + 
                      '\nPreço: RS' + imovel.preco.toString()
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )
    );
  }
}