import 'package:prova_2/model/imovel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class ImovelDao {

  static ImovelDao _databaseDao;
  static Database _database;

  // Singleton: só uma instancia da classe
  ImovelDao._createInstance();

  factory ImovelDao() {
    if (_databaseDao == null) {
      _databaseDao = ImovelDao._createInstance();
    }
    return _databaseDao;
  }

  Future<Database> get database async {
    if (_databaseDao == null) {
      _database = await createDatabase();
    }
    return _database;
  }

  void createTables(Database db, int version) async {
    String query = 'CREATE TABLE imoveis (id INTEGER PRIMARY KEY AUTOINCREMENT, tipo TEXT, numero INTEGER, nomerua TEXT, areatotal REAL, preco REAL)';
    await db.execute(query);
  }

  Future<Database> createDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = folder.path + 'baseimoveis.bd';
    var db = await openDatabase(path, version: 1, onCreate: createTables);
    return db;
  }

  Future<int> inserirImovel(Imovel imovel) async {
    Database db = await this.database;
    var results = await db.insert('imoveis', imovel.convertObjectToMAP());
    return results;
  }

  listarImoveis() async {
    Database db = await this.database;
    String query = 'SELECT * from imoveis';
    List listaImoveis = await db.rawQuery(query);
    return listaImoveis;
  }

}