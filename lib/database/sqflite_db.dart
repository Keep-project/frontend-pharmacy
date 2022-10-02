import 'package:path/path.dart' as p;
import 'package:pharmacy_app/database/models/carnet.dart';
import 'package:pharmacy_app/database/models/categorie.dart';
import 'package:pharmacy_app/database/models/consultation.dart';
import 'package:pharmacy_app/database/models/entrepot.dart';
import 'package:pharmacy_app/database/models/facture.dart';
import 'package:pharmacy_app/database/models/historiqueprix.dart';
import 'package:pharmacy_app/database/models/inventaire.dart';
import 'package:pharmacy_app/database/models/inventaireMedicament.dart';
import 'package:pharmacy_app/database/models/maladie.dart';
import 'package:pharmacy_app/database/models/medicament.dart';
import 'package:pharmacy_app/database/models/medicamentFacture.dart';
import 'package:pharmacy_app/database/models/mouvementStock.dart';
import 'package:pharmacy_app/database/models/note.dart';
import 'package:pharmacy_app/database/models/pharmacie.dart';
import 'package:pharmacy_app/database/models/symptome.dart';
import 'package:pharmacy_app/database/models/user.dart';
import 'package:sqflite/sqflite.dart';

class PharmacieDatabase {
  static const _databaseName = "Pharmacy.db";
  static const _databaseVersion = 1;

  static final PharmacieDatabase instance = PharmacieDatabase._init();

  static Database? _database;

  PharmacieDatabase._init();

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
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    const idType = "BIGINT PRIMARY KEY AUTOINCREMENT";
    const boolType = "BOOLEAN NOT NULL";
    const integerType = "BIGINT NOT NULL";
    const realType = "REAL NULL";
    const textType = "TEXT NOT NULL";

    /*  Création de la table Catégorie
    Pour catégoriser les médicaments
    */
    await db.execute('''  
        CREATE TABLE $tableCategorie(
          ${CategorieFields.id} $idType,
          ${CategorieFields.libelle} $textType
        )''');

    /*  Création de la table Utilisateur
    Pour enregistrer les utilisateur de la plateforme
    */
    await db.execute('''  
        CREATE TABLE $tableUser(
          ${UserFields.id} $idType,
          ${UserFields.password} $textType,
          ${UserFields.lastLogin} $textType,
          ${UserFields.isSuperuser} $boolType,
          ${UserFields.username} $textType,
          ${UserFields.firstName} $textType,
          ${UserFields.lastName} $textType,
          ${UserFields.email} $textType,
          ${UserFields.isStaff} $boolType,
          ${UserFields.isActive} $boolType,
          ${UserFields.dateJoined} $textType,
          ${UserFields.adresse} $textType,
          ${UserFields.avatar} $textType,
          ${UserFields.status} $textType,
          ${UserFields.experience} $textType,
        )''');

    /**  Création de la table Utilisateur
    Pour enregistrer les utilisateur de la plateforme
    */
    await db.execute('''  
        CREATE TABLE $tableCarnet(
          ${CarnetFields.id} $idType,
          ${CarnetFields.user} $integerType,
          ${CarnetFields.created_at} $textType,
          ${CarnetFields.updated_at} $textType,
          ${CarnetFields.consultation} $integerType,
          ${CarnetFields.maladie} $integerType,

          FOREIGN KEY (${CarnetFields.maladie})
          REFERENCES $tableMaladie (${MaladieFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${CarnetFields.consultation})
          REFERENCES $tableConsultation (${ConsultationFields.id}) 
          ON DELETE CASCADE,
        )''');

    /**  Création de la table Consultation
    Pour enregistrer les consultations des utilisateurs
    */
    await db.execute('''  
        CREATE TABLE $tableConsultation(
          ${ConsultationFields.id} $idType,
          ${ConsultationFields.created_at} $textType,
          ${ConsultationFields.updated_at} $textType,
          ${ConsultationFields.symptome} $integerType,
          ${ConsultationFields.user} $integerType,

          FOREIGN KEY (${ConsultationFields.symptome})
          REFERENCES $tableSymptome (${SymptomeFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${ConsultationFields.user})
          REFERENCES $tableUser (${UserFields.id}) 
          ON DELETE CASCADE,

        )''');

    /**  Création de la table Entrepot
    Pour enregistrer les entrepots d'une pharmacie
    */
    await db.execute('''  
        CREATE TABLE $tableEntrepot(
          ${EntrepotFields.id} $idType,
          ${EntrepotFields.nom} $textType,
          ${EntrepotFields.pays} $textType,
          ${EntrepotFields.ville} $textType,
          ${EntrepotFields.telephone} $textType,
          ${EntrepotFields.description} $textType,
          ${EntrepotFields.updated_at} $textType,
          ${EntrepotFields.pharmacie} $integerType,

          FOREIGN KEY (${EntrepotFields.pharmacie})
          REFERENCES $tablePharmacie (${PharmacieFields.id}) 
          ON DELETE CASCADE,
        )''');

    /**  Création de la table Facture
    Pour enregistrer les factures des pharmacies
    */
    await db.execute('''  
        CREATE TABLE $tableFacture(
          ${FactureFields.id} $idType,
          ${FactureFields.montantTotal} $integerType,
          ${FactureFields.quantiteTotal} $integerType,
          ${FactureFields.reduction} $integerType,
          ${FactureFields.note} $textType,
          ${FactureFields.updated_at} $textType,
          ${FactureFields.updated_at} $textType,
          ${FactureFields.utilisateur} $integerType,

          FOREIGN KEY (${FactureFields.utilisateur})
          REFERENCES $tableUser (${UserFields.id}) 
          ON DELETE CASCADE,


        )''');

    /**  Création de la table HistoriquePrix
    Pour enregistrer les historiques des prix
    */
    await db.execute('''  
        CREATE TABLE $tableHistoriquePrix(
          ${HistoriquePrixFields.id} $idType,
          ${HistoriquePrixFields.basePrix} $textType,
          ${HistoriquePrixFields.tva} $realType,
          ${HistoriquePrixFields.prixVente} $integerType,
          ${HistoriquePrixFields.updated_at} $textType,
          ${HistoriquePrixFields.updated_at} $textType,
          ${HistoriquePrixFields.medicament} $integerType,
          ${HistoriquePrixFields.utilisateur} $integerType,
        )''');

    /**  Création de la table Inventaire
    Pour enregistrer les inventaires des pharmacies
    */
    await db.execute('''  
        CREATE TABLE $tableInventaire(
          ${InventaireFields.id} $idType,
          ${InventaireFields.libelle} $textType,
          ${InventaireFields.updated_at} $textType,
          ${InventaireFields.updated_at} $textType,
          ${InventaireFields.entrepot} $integerType,

          FOREIGN KEY (${InventaireFields.entrepot})
          REFERENCES $tableEntrepot (${EntrepotFields.id}) 
          ON DELETE CASCADE,
        )''');

    /**  Création de la table InventaireMedicament
    Pour enregistrer les médicaments des Inventaire des pharmacies
    */
    await db.execute('''  
        CREATE TABLE $tableInventaireMedicament(
          ${InventaireMedicamentFields.quantiteAttendue} $integerType,
          ${InventaireMedicamentFields.quantiteReelle} $integerType,
          ${InventaireMedicamentFields.updated_at} $textType,
          ${InventaireMedicamentFields.updated_at} $textType,
          ${InventaireMedicamentFields.inventaire} $integerType,
          ${InventaireMedicamentFields.medicament} $integerType,

          PRIMARY KEY (${InventaireMedicamentFields.inventaire}, ${InventaireMedicamentFields.medicament}),

          FOREIGN KEY (${InventaireMedicamentFields.inventaire})
          REFERENCES $tableInventaire (${InventaireFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${InventaireMedicamentFields.medicament})
          REFERENCES $tableMedicament (${MedicamentFields.id}) 
          ON DELETE CASCADE,
        )''');

/*  Création de la table Maladie
    Pour enregistrer les maladies
    */
    await db.execute('''  
        CREATE TABLE $tableMaladie(
          ${MaladieFields.id} $idType,
          ${MaladieFields.libelle} $textType,
          ${MaladieFields.updated_at} $textType,
          ${MaladieFields.updated_at} $textType,
        )''');

    /*  Création de la table Medicament
    Pour enregistrer les médicaments
    */
    await db.execute('''  
        CREATE TABLE $tableMedicament(
          ${MedicamentFields.id} $idType,
          ${MedicamentFields.nom} $textType,
          ${MedicamentFields.prix} $integerType,
          ${MedicamentFields.marque} $textType,
          ${MedicamentFields.dateExp} $textType,
          ${MedicamentFields.image} $textType,
          ${MedicamentFields.masse} $textType,
          ${MedicamentFields.qteStock} $integerType CHECK(${MedicamentFields.qteStock} >= 0)),
          ${MedicamentFields.description} $textType,
          ${MedicamentFields.posologie} $textType,
          ${MedicamentFields.voix} $integerType,
          ${MedicamentFields.updated_at} $textType,
          ${MedicamentFields.updated_at} $textType,
          ${MedicamentFields.categorie} $integerType,
          ${MedicamentFields.pharmacie} $integerType,
          ${MedicamentFields.user} $integerType,
          ${MedicamentFields.stockAlert} $integerType,
          ${MedicamentFields.stockOptimal} $integerType,
          ${MedicamentFields.entrepot} $integerType,


          FOREIGN KEY (${MedicamentFields.categorie})
          REFERENCES $tableCategorie (${MedicamentFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${MedicamentFields.user})
          REFERENCES $tableUser (${UserFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${MedicamentFields.pharmacie})
          REFERENCES $tablePharmacie (${PharmacieFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${MedicamentFields.entrepot})
          REFERENCES $tableEntrepot (${EntrepotFields.id}) 
          ON DELETE CASCADE,
          
        )''');

    /*  Création de la table MedicamentFacture
    Pour enregistrer les médicaments des factures
    */
    await db.execute('''  
        CREATE TABLE $tableMedicamentFacture(
          ${MedicamentFactureFields.montant} $integerType,
          ${MedicamentFactureFields.quantite} $integerType,
          ${MedicamentFactureFields.updated_at} $textType,
          ${MedicamentFactureFields.updated_at} $textType,
          ${MedicamentFactureFields.facture} $integerType,
          ${MedicamentFactureFields.medicament} $integerType,

          PRIMARY KEY (${MedicamentFactureFields.facture}, ${MedicamentFactureFields.medicament}),

          FOREIGN KEY (${MedicamentFactureFields.facture})
          REFERENCES $tableFacture (${FactureFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${MedicamentFactureFields.medicament})
          REFERENCES $tableMedicament (${MedicamentFields.id}) 
          ON DELETE CASCADE,
        )''');

    /*  Création de la table MouvementStock
    Pour enregistrer les mouvements de stock des produits
    */
    await db.execute('''  
        CREATE TABLE $tableMouvementStock(
          ${MouvementStockFields.description} $textType,
          ${MouvementStockFields.quantite} $integerType,
          ${MouvementStockFields.updated_at} $textType,
          ${MouvementStockFields.updated_at} $textType,
          ${MouvementStockFields.entrepot} $integerType,
          ${MouvementStockFields.medicament} $integerType,


          PRIMARY KEY (${MouvementStockFields.entrepot}, ${MouvementStockFields.medicament}),

          FOREIGN KEY (${MouvementStockFields.entrepot})
          REFERENCES $tableEntrepot (${EntrepotFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${MouvementStockFields.medicament})
          REFERENCES $tableMedicament (${MedicamentFields.id}) 
          ON DELETE CASCADE,
        )''');

    /*  Création de la table Pharmacie
    Pour enregistrer les pharmacies
    */
    await db.execute('''  
        CREATE TABLE $tablePharmacie(
          ${PharmacieFields.id} $idType,
          ${PharmacieFields.libelle} $textType,
          ${PharmacieFields.nom} $textType,
          ${PharmacieFields.localisation} $textType,
          ${PharmacieFields.tel} $textType,
          ${PharmacieFields.latitude} $realType,
          ${PharmacieFields.longitude} $realType,
          ${PharmacieFields.ouverture} $textType,
          ${PharmacieFields.fermeture} $textType,
          ${PharmacieFields.updated_at} $textType,
          ${PharmacieFields.updated_at} $textType,
          ${PharmacieFields.user} $integerType,
          ${PharmacieFields.email} $textType,
          FOREIGN KEY (${PharmacieFields.user})
          REFERENCES $tableUser (${UserFields.id}) 
          ON DELETE CASCADE
        )''');

    /*  Création de la table Symptome
    Pour enregistrer les symptomes des maladies
    */
    await db.execute('''  
        CREATE TABLE $tableSymptome(
          ${SymptomeFields.id} $idType,
          ${PharmacieFields.libelle} $textType,
          ${PharmacieFields.updated_at} $textType,
          ${PharmacieFields.updated_at} $textType,
        )''');

    /** Table d'exemple */
    await db.execute('''  
        CREATE TABLE $tableNote(
          ${NoteFields.id} $idType,
          ${NoteFields.isImportant} $boolType,
          ${NoteFields.number} $integerType,
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
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    } else {
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
      whereArgs: [
        note.id,
      ],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tableNote,
      where: "${NoteFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
