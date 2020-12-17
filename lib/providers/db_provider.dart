import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrreader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

//Singleton
class DBProvider{

  static Database _database;
  //Instancia
  static final DBProvider db = DBProvider._();
  //Constuctor privado
  DBProvider._();

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    //Path donde almacenamos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    //Hemos creado el path
    print(path);
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async{
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      } 
    );
  }

  //INSERT
  Future<int> insertScan(ScanModel scan) async {
    final db = await database;
    final res = await db.insert('Scans', scan.toJson());
    //El res es el id del último registro insertado
    return res;
  }

  //SELECT por ID
  Future<ScanModel> selectScanById(int scanId) async{
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [scanId]);
    return res.isNotEmpty
          ? ScanModel.fromJson(res.first)
          : null;
  }

  //SELECT de todos
  Future<List<ScanModel>> findAllScans() async{
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty
          ? res.map((scan) => ScanModel.fromJson(scan)).toList()
          : [];

  }

  //SELECT por tipo
  Future<List<ScanModel>> findScansByType (String tipo) async{
    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    return res.isNotEmpty
          ? res.map((scanWithType) => ScanModel.fromJson(scanWithType)).toList()
          : [];
  }

  //UPDATE
  Future<int> updateScan(ScanModel nuevoScan) async{
    final db = await database;
    final res = await db.update(
      'Scans', 
      nuevoScan.toJson(), 
      where: 'id = ?', 
      whereArgs: [nuevoScan.id]
    ); 
    return res;
  }

  //DELETE de un registro
  Future<int> deleteScan(int id) async{
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  //DELETE de todos los registros
  Future<int> deleteAllScans() async{
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }

  //DELETE por tipo
  Future<int> deleteScanByType(String tipo) async{
    final db = await database;
    final res =await db.delete('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    return res;
  }
}