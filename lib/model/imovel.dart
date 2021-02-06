class Imovel {
  int _id;
  String _tipo;
  int _numero;
  String _nomerua;
  double _areatotal;
  double _preco;
  
  // ID
  int get id => _id;
  set id(int value) => _id = value;

  // TIPO
  String get tipo => _tipo;
  set tipo(String value) => _tipo = value;

  // NUMERO
  int get numero => _numero;
  set numero(int value) => _numero = value;

  // NOMERUA
  String get nomerua => _nomerua;
  set nomerua(String value) => _nomerua = value;

  // AREA TOTAL
  double get areatotal => _areatotal;
  set areatotal(double value) => _areatotal = value;

  // PRECO
  double get preco => _preco;
  set preco(double value) => _preco = value;
  
  // Constructor
  Imovel(
    this._tipo, 
    this._numero, 
    this._nomerua, 
    this._areatotal, 
    this._preco
  );

  // Object to MAP
  Map<String, dynamic> convertObjectToMAP() {
    var map = Map<String, dynamic>();

    map['id'] = this._id;
    map['tipo'] = this._tipo;
    map['numero'] = this._numero;
    map['nomerua'] = this._nomerua;
    map['areatotal'] = this._areatotal;
    map['preco'] = this._preco;

    return map;
  }

  // MAP to Object
  Imovel.convertMAPToObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._tipo = map['tipo'];
    this._numero = map['numero'];
    this._nomerua = map['nomerua'];
    this._areatotal = map['areatotal'];
    this._preco = map['preco'];
  }
}