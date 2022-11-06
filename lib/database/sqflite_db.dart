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
        version: _databaseVersion, onCreate: _onCreateDB,);
  }

  Future _onCreateDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
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
          ${UserFields.isUpdate} $boolType
        )''');

    /**  Création de la table Carnet
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
          ${CarnetFields.isUpdate} $boolType,

          FOREIGN KEY (${CarnetFields.maladie})
          REFERENCES $tableMaladie (${MaladieFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${CarnetFields.consultation})
          REFERENCES $tableConsultation (${ConsultationFields.id}) 
          ON DELETE CASCADE
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
          ${ConsultationFields.isUpdate} $boolType,

          FOREIGN KEY (${ConsultationFields.symptome})
          REFERENCES $tableSymptome (${SymptomeFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${ConsultationFields.user})
          REFERENCES $tableUser (${UserFields.id}) 
          ON DELETE CASCADE

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
          ${EntrepotFields.created_at} $textType,
          ${EntrepotFields.updated_at} $textType,
          ${EntrepotFields.pharmacie} $integerType,
          ${EntrepotFields.isUpdate} $boolType,

          FOREIGN KEY (${EntrepotFields.pharmacie})
          REFERENCES $tablePharmacie (${PharmacieFields.id}) 
          ON DELETE CASCADE
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
          ${FactureFields.created_at} $textType,
          ${FactureFields.updated_at} $textType,
          ${FactureFields.utilisateur} $integerType,
          ${FactureFields.isUpdate} $boolType,

          FOREIGN KEY (${FactureFields.utilisateur})
          REFERENCES $tableUser (${UserFields.id}) 
          ON DELETE CASCADE

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
          ${HistoriquePrixFields.created_at} $textType,
          ${HistoriquePrixFields.updated_at} $textType,
          ${HistoriquePrixFields.medicament} $integerType,
          ${HistoriquePrixFields.utilisateur} $integerType,
          ${HistoriquePrixFields.isUpdate} $boolType,

          FOREIGN KEY (${HistoriquePrixFields.utilisateur})
          REFERENCES $tableUser (${UserFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${HistoriquePrixFields.medicament})
          REFERENCES $tableMedicament (${MedicamentFields.id}) 
          ON DELETE CASCADE
        )''');

    /**  Création de la table Inventaire
    Pour enregistrer les inventaires des pharmacies
    */
    await db.execute('''  
        CREATE TABLE $tableInventaire(
          ${InventaireFields.id} $idType,
          ${InventaireFields.libelle} $textType,
          ${InventaireFields.created_at} $textType,
          ${InventaireFields.updated_at} $textType,
          ${InventaireFields.entrepot} $integerType,
          ${InventaireFields.isUpdate} $boolType,

          FOREIGN KEY (${InventaireFields.entrepot})
          REFERENCES $tableEntrepot (${EntrepotFields.id}) 
          ON DELETE CASCADE
        )''');

    /**  Création de la table InventaireMedicament
    Pour enregistrer les médicaments des Inventaire des pharmacies
    */
    await db.execute('''  
        CREATE TABLE $tableInventaireMedicament(
          ${InventaireMedicamentFields.quantiteAttendue} $integerType,
          ${InventaireMedicamentFields.quantiteReelle} $integerType,
          ${InventaireMedicamentFields.created_at} $textType,
          ${InventaireMedicamentFields.updated_at} $textType,
          ${InventaireMedicamentFields.inventaire} $integerType,
          ${InventaireMedicamentFields.medicament} $integerType,
          ${InventaireMedicamentFields.isUpdate} $boolType,

          PRIMARY KEY (${InventaireMedicamentFields.inventaire}, ${InventaireMedicamentFields.medicament}),

          FOREIGN KEY (${InventaireMedicamentFields.inventaire})
          REFERENCES $tableInventaire (${InventaireFields.id}) 
          ON DELETE CASCADE

          FOREIGN KEY (${InventaireMedicamentFields.medicament})
          REFERENCES $tableMedicament (${MedicamentFields.id}) 
          ON DELETE CASCADE
        )''');

/*  Création de la table Maladie
    Pour enregistrer les maladies
    */
    await db.execute('''  
        CREATE TABLE $tableMaladie(
          ${MaladieFields.id} $idType,
          ${MaladieFields.libelle} $textType,
          ${MaladieFields.created_at} $textType,
          ${MaladieFields.updated_at} $textType,
          ${MaladieFields.isUpdate} $boolType
        )''');

    /*  Création de la table Medicament
    Pour enregistrer les médicaments
    */
    await db.execute('''  
        CREATE TABLE $tableMedicament(
          ${MedicamentFields.id} $idType,
          ${MedicamentFields.idMedicament} $integerType,
          ${MedicamentFields.nom} $textType,
          ${MedicamentFields.prix} $integerType,
          ${MedicamentFields.marque} $textType,
          ${MedicamentFields.dateExp} $textType,
          ${MedicamentFields.image} $textType,
          ${MedicamentFields.masse} $textType,
          ${MedicamentFields.qteStock} $integerType CHECK(${MedicamentFields.qteStock} >= 0),
          ${MedicamentFields.description} $textType,
          ${MedicamentFields.posologie} $textType,
          ${MedicamentFields.voix} $integerType,
          ${MedicamentFields.created_at} $textType,
          ${MedicamentFields.updated_at} $textType,
          ${MedicamentFields.categorie} $integerType,
          ${MedicamentFields.pharmacie} $integerType,
          ${MedicamentFields.user} $integerType,
          ${MedicamentFields.stockAlert} $integerType,
          ${MedicamentFields.stockOptimal} $integerType,
          ${MedicamentFields.entrepot} $integerType,
          ${MedicamentFields.isUpdate} $boolType,

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
          ON DELETE CASCADE
          
        )''');

    /*  Création de la table MedicamentFacture
    Pour enregistrer les médicaments des factures
    */
    await db.execute('''  
        CREATE TABLE $tableMedicamentFacture(
          ${MedicamentFactureFields.montant} $integerType,
          ${MedicamentFactureFields.quantite} $integerType,
          ${MedicamentFactureFields.created_at} $textType,
          ${MedicamentFactureFields.updated_at} $textType,
          ${MedicamentFactureFields.facture} $integerType,
          ${MedicamentFactureFields.medicament} $integerType,
          ${MedicamentFactureFields.isUpdate} $boolType,

          PRIMARY KEY (${MedicamentFactureFields.facture}, ${MedicamentFactureFields.medicament}),

          FOREIGN KEY (${MedicamentFactureFields.facture})
          REFERENCES $tableFacture (${FactureFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${MedicamentFactureFields.medicament})
          REFERENCES $tableMedicament (${MedicamentFields.id}) 
          ON DELETE CASCADE
        )''');

    /*  Création de la table MouvementStock
    Pour enregistrer les mouvements de stock des produits
    */
    await db.execute('''  
        CREATE TABLE $tableMouvementStock(
          ${MouvementStockFields.description} $textType,
          ${MouvementStockFields.quantite} $integerType,
          ${MouvementStockFields.created_at} $textType,
          ${MouvementStockFields.updated_at} $textType,
          ${MouvementStockFields.entrepot} $integerType,
          ${MouvementStockFields.medicament} $integerType,
          ${MouvementStockFields.isUpdate} $boolType,


          PRIMARY KEY (${MouvementStockFields.entrepot}, ${MouvementStockFields.medicament}),

          FOREIGN KEY (${MouvementStockFields.entrepot})
          REFERENCES $tableEntrepot (${EntrepotFields.id}) 
          ON DELETE CASCADE,

          FOREIGN KEY (${MouvementStockFields.medicament})
          REFERENCES $tableMedicament (${MedicamentFields.id}) 
          ON DELETE CASCADE
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
          ${PharmacieFields.created_at} $textType,
          ${PharmacieFields.updated_at} $textType,
          ${PharmacieFields.user} $integerType,
          ${PharmacieFields.email} $textType,
          ${PharmacieFields.isUpdate} $boolType,

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
          ${SymptomeFields.libelle} $textType,
          ${SymptomeFields.created_at} $textType,
          ${SymptomeFields.updated_at} $textType,
          ${SymptomeFields.updated_at} $boolType
        )''');
  }

  /**
 * Méthodes / Requêtes SQL
 */

  /// La table Categorie

  Future<Categorie> createCategorie(Categorie categorie) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableCategorie, categorie.toMap());
    });
    return categorie.copy(id: id);

    // exemple

    // await PharmacieDatabase.instance.createCategorie(Categorie(libelle: 'Adultes'));
  }

  Future<Categorie?> readCategorie(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCategorie,
      columns: CategorieFields.values,
      where: "${CategorieFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return Categorie.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Categorie>> readAllCategorie() async {
    final db = await instance.database;
    const orderBy = "${CategorieFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableCategorie,
      orderBy: orderBy,
    );
    return List<Categorie>.from(result.map((json) => Categorie.fromMap(json)));
  }

  Future<int> updateCategorie(Categorie categorie) async {
    final db = await instance.database;

    return db.update(
      tableCategorie,
      categorie.toMap(),
      where: "${CategorieFields.id} = ?",
      whereArgs: [
        categorie.id,
      ],
    );
  }

  Future<int> deleteCategorie(int id) async {
    final db = await instance.database;

    return db.delete(
      tableCategorie,
      where: "${CategorieFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table Utilisateur

  Future<User> createUser(User user) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableUser, user.toMap());
    });
    return user.copy(id: id);
  }

  Future<User?> readUser(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUser,
      columns: UserFields.values,
      where: "${UserFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<User>> readAllUser() async {
    final db = await instance.database;
    const orderBy = "${UserFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableUser,
      orderBy: orderBy,
    );
    return List<User>.from(result.map((json) => User.fromMap(json)));
  }

  Future<int> updateUser(User user) async {
    final db = await instance.database;

    return db.update(
      tableUser,
      user.toMap(),
      where: "${UserFields.id} = ?",
      whereArgs: [
        user.id,
      ],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;

    return db.delete(
      tableUser,
      where: "${UserFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table Carnet

  Future<Carnet> createCarnet(Carnet carnet) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableCarnet, carnet.toMap());
    });
    return carnet.copy(id: id);
  }

  Future<Carnet?> readCarnet(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCarnet,
      columns: CarnetFields.values,
      where: "${CarnetFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return Carnet.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Carnet>> readAllCarnet() async {
    final db = await instance.database;
    const orderBy = "${CarnetFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableCarnet,
      orderBy: orderBy,
    );
    return List<Carnet>.from(result.map((json) => Carnet.fromMap(json)));
  }

  Future<int> updateCarnet(Carnet carnet) async {
    final db = await instance.database;

    return db.update(
      tableCarnet,
      carnet.toMap(),
      where: "${CarnetFields.id} = ?",
      whereArgs: [
        carnet.id,
      ],
    );
  }

  Future<int> deleteCarnet(int id) async {
    final db = await instance.database;

    return db.delete(
      tableCarnet,
      where: "${CarnetFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table Consultation

  Future<Consultation> createConsultation(Consultation consultation) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableConsultation, consultation.toMap());
    });
    return consultation.copy(id: id);
  }

  Future<Consultation?> readConsultation(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableConsultation,
      columns: ConsultationFields.values,
      where: "${ConsultationFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return Consultation.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Consultation>> readAllConsultation() async {
    final db = await instance.database;
    const orderBy = "${ConsultationFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableConsultation,
      orderBy: orderBy,
    );
    return List<Consultation>.from(
        result.map((json) => Consultation.fromMap(json)));
  }

  Future<int> updateConsultation(Consultation consultation) async {
    final db = await instance.database;

    return db.update(
      tableConsultation,
      consultation.toMap(),
      where: "${ConsultationFields.id} = ?",
      whereArgs: [
        consultation.id,
      ],
    );
  }

  Future<int> deleteConsultation(int id) async {
    final db = await instance.database;

    return db.delete(
      tableConsultation,
      where: "${ConsultationFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table Entrepot

  Future<Entrepot> createEntrepot(Entrepot entrepot) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableEntrepot, entrepot.toMap());
    });
    return entrepot.copy(id: id);

    // Exemple

    // Entrepot entrepot = await PharmacieDatabase.instance
    //       .createEntrepot(
    //         Entrepot(
    //           nom: 'Magasin 1',
    //           pays: 'Cameroun',
    //           ville: 'Yaoundé',
    //           telephone: '652310829',
    //           description: 'Entrepot de stockage de produits pharmaceutiques pour adultes',
    //           created_at: DateTime.now(),
    //           updated_at: DateTime.now(),
    //           pharmacie: pharmacy.first.id,
    //         )
    //       );
  }

  Future<Entrepot?> readEntrepot(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableEntrepot,
      columns: EntrepotFields.values,
      where: "${EntrepotFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return Entrepot.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Entrepot>> readAllEntrepot() async {
    final db = await instance.database;
    const orderBy = "${EntrepotFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableEntrepot,
      orderBy: orderBy,
    );
    return List<Entrepot>.from(result.map((json) => Entrepot.fromMap(json)));
  }

  Future<int> updateEntrepot(Entrepot entrepot) async {
    final db = await instance.database;

    return db.update(
      tableEntrepot,
      entrepot.toMap(),
      where: "${EntrepotFields.id} = ?",
      whereArgs: [
        entrepot.id,
      ],
    );
  }

  Future<int> deleteEntrepot(int id) async {
    final db = await instance.database;

    return db.delete(
      tableEntrepot,
      where: "${EntrepotFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table Facture

  Future<Facture> createFacture(Facture facture) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableFacture, facture.toMap());
    });
    return facture.copy(id: id);
  }

  Future<Facture?> readFacture(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFacture,
      columns: FactureFields.values,
      where: "${FactureFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return Facture.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Facture>> readAllFacture() async {
    final db = await instance.database;
    const orderBy = "${FactureFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableFacture,
      orderBy: orderBy,
    );
    return List<Facture>.from(result.map((json) => Facture.fromMap(json)));
  }

  Future<int> updateFacture(Facture facture) async {
    final db = await instance.database;

    return db.update(
      tableFacture,
      facture.toMap(),
      where: "${FactureFields.id} = ?",
      whereArgs: [
        facture.id,
      ],
    );
  }

  Future<int> deleteFacture(int id) async {
    final db = await instance.database;

    return db.delete(
      tableFacture,
      where: "${FactureFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table HistoriquePrix

  Future<HistoriquePrix> createHistoriquePrix(
      HistoriquePrix historiquePrix) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableHistoriquePrix, historiquePrix.toMap());
    });
    return historiquePrix.copy(id: id);
  }

  Future<HistoriquePrix?> readHistoriquePrix(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableHistoriquePrix,
      columns: HistoriquePrixFields.values,
      where: "${HistoriquePrixFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return HistoriquePrix.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<HistoriquePrix>> readAllHistoriquePrix() async {
    final db = await instance.database;
    const orderBy = "${HistoriquePrixFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableHistoriquePrix,
      orderBy: orderBy,
    );
    return List<HistoriquePrix>.from(
        result.map((json) => HistoriquePrix.fromMap(json)));
  }

  Future<int> updateHistoriquePrix(HistoriquePrix historiquePrix) async {
    final db = await instance.database;

    return db.update(
      tableHistoriquePrix,
      historiquePrix.toMap(),
      where: "${HistoriquePrixFields.id} = ?",
      whereArgs: [
        historiquePrix.id,
      ],
    );
  }

  Future<int> deleteHistoriquePrix(int id) async {
    final db = await instance.database;

    return db.delete(
      tableHistoriquePrix,
      where: "${HistoriquePrixFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table Inventaire

  Future<Inventaire> createInventaire(Inventaire inventaire) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableInventaire, inventaire.toMap());
    });
    return inventaire.copy(id: id);
  }

  Future<Inventaire?> readInventaire(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableInventaire,
      columns: InventaireFields.values,
      where: "${InventaireFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return Inventaire.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Inventaire>> readAllInventaire() async {
    final db = await instance.database;
    const orderBy = "${InventaireFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableInventaire,
      orderBy: orderBy,
    );
    return List<Inventaire>.from(
        result.map((json) => Inventaire.fromMap(json)));
  }

  Future<int> updateInventaire(Inventaire inventaire) async {
    final db = await instance.database;

    return db.update(
      tableInventaire,
      inventaire.toMap(),
      where: "${InventaireFields.id} = ?",
      whereArgs: [
        inventaire.id,
      ],
    );
  }

  Future<int> deleteInventaire(int id) async {
    final db = await instance.database;

    return db.delete(
      tableInventaire,
      where: "${InventaireFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table InventaireMedicament

  Future<InventaireMedicament> createInventaireMedicament(
      InventaireMedicament inventaireMedicament) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(
          tableInventaireMedicament, inventaireMedicament.toMap());
    });
    return inventaireMedicament.copy(id: id);
  }

  Future<InventaireMedicament?> readInventaireMedicament(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableInventaireMedicament,
      columns: InventaireMedicamentFields.values,
      where: "${InventaireMedicamentFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return InventaireMedicament.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<InventaireMedicament>> readAllInventaireMedicament() async {
    final db = await instance.database;
    const orderBy = "${InventaireMedicamentFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableInventaireMedicament,
      orderBy: orderBy,
    );
    return List<InventaireMedicament>.from(
        result.map((json) => InventaireMedicament.fromMap(json)));
  }

  Future<int> updateInventaireMedicament(
      InventaireMedicament inventaireMedicament) async {
    final db = await instance.database;

    return db.update(
      tableInventaireMedicament,
      inventaireMedicament.toMap(),
      where: "${InventaireMedicamentFields.id} = ?",
      whereArgs: [
        inventaireMedicament.id,
      ],
    );
  }

  Future<int> deleteInventaireMedicament(int id) async {
    final db = await instance.database;

    return db.delete(
      tableInventaireMedicament,
      where: "${InventaireMedicamentFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table Maladie

  Future<Maladie> createMaladie(Maladie maladie) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableMaladie, maladie.toMap());
    });
    return maladie.copy(id: id);
  }

  Future<Maladie?> readMaladie(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMaladie,
      columns: MaladieFields.values,
      where: "${MaladieFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return Maladie.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Maladie>> readAllMaladie() async {
    final db = await instance.database;
    const orderBy = "${MaladieFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableMaladie,
      orderBy: orderBy,
    );
    return List<Maladie>.from(result.map((json) => Maladie.fromMap(json)));
  }

  Future<int> updateMaladie(Maladie maladie) async {
    final db = await instance.database;

    return db.update(
      tableInventaireMedicament,
      maladie.toMap(),
      where: "${MaladieFields.id} = ?",
      whereArgs: [
        maladie.id,
      ],
    );
  }

  Future<int> deleteMaladie(int id) async {
    final db = await instance.database;

    return db.delete(
      tableMaladie,
      where: "${MaladieFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table Medicament

  Future<Medicament> createMedicament(Medicament medicament) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableMedicament, medicament.toMap());
    });
    return medicament.copy(id: id);
  }

  Future<Medicament?> readMedicament(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMedicament,
      columns: MedicamentFields.values,
      where: "${MedicamentFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return Medicament.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Medicament>> readAllMedicament() async {
    final db = await instance.database;
    const orderBy = "${MedicamentFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableMedicament,
      orderBy: orderBy,
    );
    return List<Medicament>.from(
        result.map((json) => Medicament.fromMap(json)));
  }

  Future<int> updateMedicament(Medicament medicament) async {
    final db = await instance.database;

    return db.update(
      tableMedicament,
      medicament.toMap(),
      where: "${MedicamentFields.id} = ?",
      whereArgs: [
        medicament.id,
      ],
    );
  }

  Future<int> deleteMedicament(int id) async {
    final db = await instance.database;

    return db.delete(
      tableMedicament,
      where: "${MedicamentFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table MedicamentFacture

  Future<MedicamentFacture> createMedicamentFacture(
      MedicamentFacture medicamentFacture) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableMedicamentFacture, medicamentFacture.toMap());
    });
    return medicamentFacture.copy(id: id);
  }

  Future<MedicamentFacture?> readMedicamentFacture(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMedicamentFacture,
      columns: MedicamentFactureFields.values,
      where: "${MedicamentFactureFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return MedicamentFacture.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<MedicamentFacture>> readAllMedicamentFacture() async {
    final db = await instance.database;
    const orderBy = "${MedicamentFactureFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableMedicament,
      orderBy: orderBy,
    );
    return List<MedicamentFacture>.from(
        result.map((json) => MedicamentFacture.fromMap(json)));
  }

  Future<int> updateMedicamentFacture(
      MedicamentFacture medicamentFacture) async {
    final db = await instance.database;

    return db.update(
      tableMedicament,
      medicamentFacture.toMap(),
      where: "${MedicamentFactureFields.id} = ?",
      whereArgs: [
        medicamentFacture.id,
      ],
    );
  }

  Future<int> deleteMedicamentFacture(int id) async {
    final db = await instance.database;

    return db.delete(
      tableMedicamentFacture,
      where: "${MedicamentFactureFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table MouvementStock

  Future<MouvementStock> createMouvementStock(
      MouvementStock mouvementStock) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableMouvementStock, mouvementStock.toMap());
    });
    return mouvementStock.copy(id: id);
  }

  Future<MouvementStock?> readMouvementStock(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMouvementStock,
      columns: MouvementStockFields.values,
      where: "${MouvementStockFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return MouvementStock.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<MouvementStock>> readAllMouvementStock() async {
    final db = await instance.database;
    const orderBy = "${MouvementStockFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableMouvementStock,
      orderBy: orderBy,
    );
    return List<MouvementStock>.from(
        result.map((json) => MouvementStock.fromMap(json)));
  }

  Future<int> updateMouvementStock(MouvementStock mouvementStock) async {
    final db = await instance.database;

    return db.update(
      tableMouvementStock,
      mouvementStock.toMap(),
      where: "${MouvementStockFields.id} = ?",
      whereArgs: [
        mouvementStock.id,
      ],
    );
  }

  Future<int> deleteMouvementStock(int id) async {
    final db = await instance.database;

    return db.delete(
      tableMouvementStock,
      where: "${MouvementStockFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table Pharmacie

  Future<Pharmacie> createPharmacie(Pharmacie pharmacie) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tablePharmacie, pharmacie.toMap());
    });
    return pharmacie.copy(id: id);
  }

  Future<Pharmacie?> readPharmacie(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablePharmacie,
      columns: PharmacieFields.values,
      where: "${PharmacieFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return Pharmacie.fromMap(maps.first);
    } else {
      return null;
    }

    // exemple
  
    // Pharmacie pharmacy = await PharmacieDatabase.instance.createPharmacie(
    //   Pharmacie(
    //     libelle: '1',
    //     nom: 'Pharmacie de la côte',
    //     localisation: "Cameroun;Yaoundé;Mvan",
    //     tel: "+237 652 310 829",
    //     latitude: 3.866667,
    //     longitude : 11.516667,
    //     ouverture: '08h30',
    //     fermeture: '19h30',
    //     created_at: DateTime.now(),
    //     updated_at: DateTime.now(),
    //     user: 1,
    //     email: 'info@gmail.com',
    //   )
    // );
  }

  Future<List<Pharmacie>> readAllPharmacie() async {
    final db = await instance.database;
    const orderBy = "${PharmacieFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tablePharmacie,
      orderBy: orderBy,
    );
    return List<Pharmacie>.from(result.map((json) => Pharmacie.fromMap(json)));
  }

  Future<int> updatePharmacie(Pharmacie pharmacie) async {
    final db = await instance.database;

    return db.update(
      tablePharmacie,
      pharmacie.toMap(),
      where: "${PharmacieFields.id} = ?",
      whereArgs: [
        pharmacie.id,
      ],
    );
  }

  Future<int> deletePharmacie(int id) async {
    final db = await instance.database;

    return db.delete(
      tablePharmacie,
      where: "${PharmacieFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// La table Symptome

  Future<Symptome> createSymptome(Symptome symptome) async {
    // Méthode permettant d'ajouter une note dans notre base de données
    final db = await instance.database;
    int id = 0;
    await db.transaction((txn) async {
      id = await txn.insert(tableSymptome, symptome.toMap());
    });
    return symptome.copy(id: id);
  }

  Future<Symptome?> readSymptome(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableSymptome,
      columns: SymptomeFields.values,
      where: "${SymptomeFields.id} = ?",
      whereArgs: [
        id,
      ],
    );

    if (maps.isNotEmpty) {
      return Symptome.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Symptome>> readAllSymptome() async {
    final db = await instance.database;
    const orderBy = "${SymptomeFields.id} ASC";

    // final result = await db.rawQuery("SELECT * FROM $tableNote ORDER BY $orderBy");
    final result = await db.query(
      tableSymptome,
      orderBy: orderBy,
    );
    return List<Symptome>.from(result.map((json) => Symptome.fromMap(json)));
  }

  Future<int> updateSymptome(Symptome symptome) async {
    final db = await instance.database;

    return db.update(
      tableSymptome,
      symptome.toMap(),
      where: "${SymptomeFields.id} = ?",
      whereArgs: [
        symptome.id,
      ],
    );
  }

  Future<int> deleteSymptome(int id) async {
    final db = await instance.database;

    return db.delete(
      tableSymptome,
      where: "${SymptomeFields.id} = ?",
      whereArgs: [
        id,
      ],
    );
  }

  /// Fin des requêtes SQL

  /// Méthode pour fermer la base de données
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
