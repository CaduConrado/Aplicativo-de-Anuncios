import 'package:sqflite/sqflite.dart';

import '../components/shopp_cart_anuncio.dart';
import 'shopping_cart_db.dart';

class ShoppingCartDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_productName TEXT,'
      '$_details TEXT,'
      '$_price DOUBLE,'
      '$_image TEXT)';
  static const String _tablename = 'shoppingCartTable';
  static const String _productName = 'name';
  static const String _details = 'details';
  static const String _price = 'price';
  static const String _image = 'image';

  save(ShoppCartAnuncio anuncio) async {
    print('Iniciando save: ');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(anuncio.nomeProduto);
    Map<String, dynamic> anuncioMap = toMap(anuncio);
    if (itemExists.isEmpty) {
      print('O anuncio não existia');
      return await bancoDeDados.insert(_tablename, anuncioMap);
    } else {
      print('O anuncio já existia');
      return await bancoDeDados.update(_tablename, anuncioMap,
          where: '$_productName = ?', whereArgs: [anuncio.nomeProduto]);
    }
  }

  Map<String, dynamic> toMap(ShoppCartAnuncio anuncio) {
    print('Convertendo anuncio em Map');
    final Map<String, dynamic> mapaDeAnuncios = {};
    mapaDeAnuncios[_productName] = anuncio.nomeProduto;
    mapaDeAnuncios[_details] = anuncio.detalhes;
    mapaDeAnuncios[_price] = anuncio.preco;
    mapaDeAnuncios[_image] = anuncio.foto;
    print('Map de Anuncios: $mapaDeAnuncios');
    return mapaDeAnuncios;
  }

  Future<List<ShoppCartAnuncio>> findAll() async {
    print('Acessando o findAll');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList(result);
  }

  List<ShoppCartAnuncio> toList(List<Map<String, dynamic>> mapaDeAnuncios) {
    print('Convertendo to List');
    final List<ShoppCartAnuncio> anuncios = [];
    for (Map<String, dynamic> linha in mapaDeAnuncios) {
      final ShoppCartAnuncio anuncio = ShoppCartAnuncio(
          foto: linha[_image],
          detalhes: linha[_details],
          preco: linha[_price],
          nomeProduto: linha[_productName]);
      anuncios.add(anuncio);
    }
    print('Lista de Anuncios $anuncios');
    return anuncios;
  }

  Future<List<ShoppCartAnuncio>> find(String nomeDoProduto) async {
    print('Acessando find: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_productName = ?',
      whereArgs: [nomeDoProduto],
    );
    print('Tarefa encontrada: ${toList(result)}');
    return toList(result);
  }

  delete(String nomeAnuncio) async {
    print('Deletando anuncio: $nomeAnuncio');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
      _tablename,
      where: '$_productName = ?',
      whereArgs: [nomeAnuncio],
    );
  }
}
