import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sounding_storage/database/database_entity.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _dbHelper;
  static Database _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_dbHelper == null) {
      _dbHelper = DatabaseHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'db_traceability.db';
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE_SOUNDING(
        $ID_SOUNDING TEXT NOT NULL,
        $DATE_SOUNDING TEXT NOT NULL,
        $TOTAL_STOCK_SOUNDING INT,
        $ADDITIONAL_SOUNDING INT,
        $PRODUCTION_SOUNDING DOUBLE,
        $NOTE_SOUNDING TEXT,
        $SOUNDING_SENT TEXT,
        $CLARIFIER_PURE_OIL DOUBLE,
        $CLARIFIER_TANK_1 DOUBLE,
        $CLARIFIER_TANK_2 DOUBLE,
        $CREATED_BY_SOUNDING TEXT NOT NULL)
    ''');
    await db.execute('''
      CREATE TABLE $TABLE_SOUNDING_CPO(
         $ID_TANK TEXT NOT NULL,
         $ID_SOUNDING_TANK TEXT NOT NULL,
         $DATE_SOUNDING_TANK TEXT NOT NULL,
         $SOUNDING_FIRST DOUBLE,
         $SOUNDING_SECOND DOUBLE,
         $SOUNDING_THIRD DOUBLE,
         $SOUNDING_FOURTH DOUBLE,
         $SOUNDING_FIFTH DOUBLE,
         $SOUNDING_MAX INT,
         $SIZE_SOUNDING_TANK DOUBLE,
         $SOUNDING_AVERAGE DOUBLE,
         $SOUNDING_M_TANK_ID DOUBLE,
         $SOUNDING_M_TANK_CODE DOUBLE,
         $SOUNDING_TEMPERATURE DOUBLE,
         $SOUNDING_VOLUME_CM DOUBLE,
         $SOUNDING_VOLUME_MM DOUBLE,
         $SOUNDING_TOTAL_VOLUME DOUBLE,
         $SOUNDING_ROUNDING_VOLUME DOUBLE,
         $SOUNDING_CONST_EXPAND DOUBLE,
         $SOUNDING_HIGH_TABLE DOUBLE,
         $SOUNDING_DENSITY DOUBLE,
         $SOUNDING_USING_COPY_DATA BOOL NOT NULL,
         $SOUNDING_IS_MANUAL BOOL NOT NULL,
         $SOUNDING_WEIGHT_STORAGE DOUBLE,
         $SOUNDING_CPO_CREATED_BY TEXT NOT NULL,
         $SOUNDING_ROUNDING_TONNAGE DOUBLE)
    ''');
    await db.execute('''
      CREATE TABLE $TABLE_QUALITY(
        $ID_QUALITY TEXT NOT NULL,
        $DATE_QUALITY TEXT NOT NULL,
        $ID_QUALITY_DOC_CHECK TEXT NOT NULL,
        $M_PRODUCT_CODE_QUALITY TEXT,
        $M_PRODUCT_ID_QUALITY TEXT,
        $FFA_QUALITY DOUBLE,
        $MOIST_QUALITY DOUBLE,
        $DIRT_QUALITY DOUBLE,
        $DOBI_QUALITY DOUBLE,
        $B_QUALITY_KERNEL DOUBLE,
        $QUALITY_CREATED_BY TEXT NOT NULL)
    ''');
    await db.execute('''
      CREATE TABLE $TABLE_QUALITY_DOC(
        $ID_QUALITY_DOC TEXT NOT NULL,
        $QUALITY_SENT_DOC TEXT,
        $CREATED_BY_QUALITY_DOC TEXT NOT NULL, 
        $DATE_QUALITY_DOC TEXT NOT NULL)
    ''');
    await db.execute('''
      CREATE TABLE $TABLE_KERNEL(
        $ID_KERNEL TEXT NOT NULL,
        $DATE_KERNEL TEXT NOT NULL,
        $BULK_SILO_ONE DOUBLE,
        $BULK_SILO_TWO DOUBLE,
        $BULK_SILO_THREE DOUBLE,
        $BULK_SILO_FOUR DOUBLE,
        $KERNEL_SENT BOOL,
        $KERNEL_CREATED_BY TEXT NOT NULL)
    ''');
    await db.execute('''
      CREATE TABLE $TABLE_USER(
        $ID_USER TEXT NOT NULL,
        $NAME_USER TEXT NOT NULL,
        $EMAIL_USER TEXT,
        $ROLE_USER TEXT,
        $USERNAME_USER TEXT,
        $MILL_ID TEXT,
        $ADDRESS TEXT,
        $GENDER TEXT,
        $COMPANY_NAME TEXT,
        $COMPANY_ID_USER TEXT,
        $PROFILE_PICTURE TEXT,
        $PHONE_NUMBER TEXT)
    ''');
    await db.execute('''
      CREATE TABLE $TABLE_STORAGE_TANK(
        $ID_STORAGE_TANK TEXT NOT NULL,
        $CODE_STORAGE_TANK TEXT NOT NULL,
        $NAME_STORAGE_TANK TEXT,
        $CAPACITY INT,
        $SURFACE_PLATE INT,
        $STANDARD_TEMPERATURE INT,
        $HEIGHT_TANK DOUBLE,
        $DENSITY DOUBLE,
        $RING DOUBLE,
        $EXPANSION_COEFFICIENT DOUBLE,
        $MILL_ID_STORAGE_TANK TEXT NOT NULL,
        $CREATED_BY_STORAGE_TANK TEXT NOT NULL,
        $CREATED_AT_STORAGE_TANK TEXT)
    ''');
    await db.execute('''
      CREATE TABLE $TABLE_MILL(
        $ID_MILL TEXT NOT NULL,
        $NAME_MILL TEXT NOT NULL,
        $CODE_MILL TEXT NOT NULL,
        $ADDRESS_MILL TEXT,
        $MAX_SOUNDING INT,
        $TOTAL_QUALITY INT,
        $LABEL_QUALITY TEXT,
        $TOTAL_SOUNDING_KERNEL INT,
        $M_COMPANY_ID TEXT NOT NULL)
    ''');
    await db.execute('''
      CREATE TABLE $TABLE_VERIFIER(
        $ID_VERIFIER TEXT NOT NULL,
        $NAME_VERIFIER TEXT NOT NULL,
        $LEVEL_LABEL TEXT NOT NULL,
        $ID_FORM TEXT)
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
