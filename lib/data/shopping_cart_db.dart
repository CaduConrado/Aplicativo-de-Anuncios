import 'package:aplicativo_anuncios/data/shopping_cart_dao.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'shoppCart.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ShoppingCartDao.tableSql);
    },
    version: 1,
  );
}
