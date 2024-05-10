import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:tugas1_0080/model/produk_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static late Database _database;
  Future<Database> get database async => _database = await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'toko.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE produk(
  id INTEGER PRIMARY KEY,
  namaProduk TEXT,
  satuan TEXT,
  jumlah INTEGER,
  hargaJual INTEGER
)
''');
  }

  Future<List<ProdukModel>> getAllProduk() async {
    Database db = await instance.database;
    var produk = await db.query('produk', orderBy: 'namaProduk');
    List<ProdukModel> produkList = produk.isNotEmpty
        ? produk.map((c) => ProdukModel.fromMap(c)).toList()
        : [];
    return produkList;
  }

  Future<List<ProdukModel>> getProdukById(int id) async {
    Database db = await instance.database;
    var produk = await db.query('produk', where: 'id = ?', whereArgs: [id]);
    List<ProdukModel> produkList = produk.isNotEmpty
        ? produk.map((c) => ProdukModel.fromMap(c)).toList()
        : [];
    return produkList;
  }

  Future<int> add(ProdukModel produk) async {
    Database db = await instance.database;

    return await db.insert('produk', produk.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;

    return await db.delete('produk', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(ProdukModel produk) async {
    Database db = await instance.database;

    return await db.update('produk', produk.toMap(),
        where: "id = ?", whereArgs: [produk.id]);
  }
}
