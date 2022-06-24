import 'package:sql_pricelist/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper{
  

  //sqlite code
  static final _databaseName = "priceList.db";
  static final _databaseVersion = 1;

  static final table = 'ProductsTable';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnPrice = 'price';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async =>
    _database ??= await _initDatabase();


  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }
  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnPrice DOUBLE NOT NULL
          )
          ''');
  }


// Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Product product) async {
    Database db = await instance.database;
    return await db.insert(table, {'name': product.name, 'price': product.price});
  }
  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }
  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database db = await instance.database;
    return await db.query(table, where: "$columnName LIKE '%$name%'");
  }
  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Product product) async {
    Database db = await instance.database;
    int id = product.toMap()['id'];
    return await db.update(table, product.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}