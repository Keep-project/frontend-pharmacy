
import 'package:path/path.dart' as p;
import 'package:pharmacy_app/database/models/note.dart';
import 'package:sqflite/sqflite.dart';


class PharmacieDB {

  static const _databaseName = "Pharmacy.db";
  static const _databaseVersion = 1;

  static final PharmacieDB instance = PharmacieDB._init();

  static Database? _database;

  PharmacieDB._init();

   Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase(_databaseName);
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    // Initialisation de la base de données
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const boolType = "BOOLEAN NOT NULL";
    const intergerType = "INTERGER INT NULL";
    const textType = "TEXT NOT NULL";

    await db.execute('''  
        CREATE TABLE $tableNote (
          ${NoteFields.id} $idType,
          ${NoteFields.isImportant} $boolType,
          ${NoteFields.number} $intergerType,
          ${NoteFields.title} $textType,
          ${NoteFields.description} $textType,
          ${NoteFields.time} $textType,
        )''');
  }


  Future<Note> create(Note note) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableNote, note.toMap());
    });
    return note.copy(id: id);
  }

  Future<Note?> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNote,
      columns: NoteFields.values,
      where: "${NoteFields.id} = ?",
      whereArgs: [id,],
    );

    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    }
    else {
      return null;
    }
  }

  Future<List<Note>> readAll() async {
    final db = await instance.database;
    const orderBy = "${NoteFields.time} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableNote,
      orderBy: orderBy,
    );
    return List<Note>.from(result.map((json) => Note.fromMap(json)));
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNote,
      note.toMap(),
      where: "${NoteFields.id} = ?",
      whereArgs: [note.id,],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tableNote,
      where: "${NoteFields.id} = ?",
      whereArgs: [id,],
    );
  }


  Future close() async {
    final db = await instance.database;
    db.close();
  }
  
}



