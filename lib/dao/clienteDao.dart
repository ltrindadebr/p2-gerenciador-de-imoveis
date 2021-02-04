//importa as bibliotecas
import 'package:appclientes/model/cliente.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class ClienteDao{

  //define os atributos
  static ClienteDao _databaseDao;
  static Database _database;

  //define os métodos para conectar com o BD
  
  //utiliza o padrão de projeto Singleton (não permite a criação de mais de uma instancia da classe)

  ClienteDao._createInstance();

  factory ClienteDao(){
    if (_databaseDao == null)
    {
      _databaseDao = ClienteDao._createInstance();
    }

    return _databaseDao;
  }

  //abre ou cria o BD
  Future<Database> get database async{
    if (_database == null) //verifica se o BD não foi criado
    {
      _database = await criaBD(); //cria o banco de dados
    }

    return _database;
  }

  //cria as tabelas no BD
  void criarTabelas(Database db, int versao) async{
    String sql = "CREATE TABLE clientes (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, email TEXT)";

    await db.execute(sql);
  }

  //cria o BD
  Future<Database> criaBD() async{
    //recuperar o caminho da pasta para salvar o BD
    Directory pasta = await getApplicationSupportDirectory();

    String caminho = pasta.path + 'bdclientes.bd';

    var bd = await openDatabase(caminho, version: 1, onCreate: criarTabelas);

    return bd;
  }

  //métodos do CRUD

  //INSERIR
  Future<int> inserirCliente(Cliente cli) async{
    //abrir o BD
    Database db = await this.database;
    //inserir
    var resultado = await db.insert("clientes", cli.conveteObjetoToMap());

    return resultado;
  }

  //LISTAR TODOS
  listarClientes() async{
      //abrir o BD
    Database db = await this.database;
    //select
    String sql = "SELECT * FROM clientes";
    List listaClientes = await db.rawQuery(sql);

    return listaClientes;
  }

  //EXCLUIR
  Future<int> excluirCliente(int id) async{
    //abrir o BD
    Database db = await this.database;
    //excluir
    var resultado = await db.delete("clientes", where: "id=?",whereArgs: [id]);

    return resultado;
  }


  //ALTERAR
  Future<int> alterarCliente(Cliente cli) async{
    //abrir o BD
    Database db = await this.database;
    //inserir
    var resultado = await db.update("clientes", cli.conveteObjetoToMap(),
      where:"id=?",whereArgs: [cli.id]);

    return resultado;
  }

}