import 'package:flutter/material.dart';
import 'package:prova_2/model/imovel.dart';
import '../dao/imovelDao.dart';
// import './cadastro.dart';

class EditarOuDeletar extends StatefulWidget {
  @override
  EditarOuDeletarState createState() => EditarOuDeletarState();
}

class EditarOuDeletarState extends State<EditarOuDeletar> {
  TextEditingController tipoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController nomeRuaController = TextEditingController();
  TextEditingController areaTotalController = TextEditingController();
  TextEditingController precoController = TextEditingController();

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

  void excluirImovel(int id) {
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Excluir imóvel"),
          content: Text("Deseja excluir o imóvel selecionado?"),
          actions: [
            RaisedButton(
              color: Colors.blue,
              child: Text("Não"),
              onPressed: (){
                Navigator.pop(context);
              }),

              RaisedButton(
              color: Colors.blue,
              child: Text("Sim"),
              onPressed: () async{ //chama o método para excluir da classe DAO
                int result = await _db.excluirImovel(id);
                listarImoveis(); //atualiza a listView
                Navigator.pop(context);
              }),
          ],
        );
      }
    );
  }

  editarImovel(Imovel imovel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Editar imóvel"),
          content: Column(
            mainAxisSize: MainAxisSize.min, //tamanho da janela
            children: [
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
            ]
          ),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: Text("Cancelar")
            ),
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: Text("Salvar")
            )
          ],
        );
      }
    );
  }
  

  @override
  Widget build(BuildContext context) {
    listarImoveis();
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar ou deletar imóveis'),
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          child: Icon(Icons.delete, color: Colors.blue),
                          onTap: (){
                            excluirImovel(imovel.id);
                          },
                        ) ,
                        GestureDetector(
                          child: Icon(Icons.edit, color: Colors.blue),
                          onTap: (){
                            editarImovel(imovel);
                          },
                        ) ,
                      ],
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