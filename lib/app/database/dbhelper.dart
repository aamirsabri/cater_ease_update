import 'package:cater_ease/model/customer_model.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../model/customer_function_model.dart';

const String DB_NAME = "cater_ease.db";
const String DB_TABLE_CUSTOMER = "customer";
const String DB_TABLE_CATERER = "caterer";
const String DB_TABLE_CUSTOMER_FUNCTION = "customer_function";

class DBHelper {
  static Database? _database;
  static get getDatabase async {
    if (_database != null) {
      return _database;
    }
    int version = 1;
    _database = await initDatabase(version);
    return _database;
  }

  static Future<Database> initDatabase(int version) async {
    String path = p.join(await getDatabasesPath(), DB_NAME);
    return await openDatabase(path, version: version, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    db.execute('''
        CREATE TABLE CUSTOMER(
          CUSTOMER_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
          CUSTOMER_NAME TEXT,         
          ADDRESS TEXT,
          MOBILE TEXT,
          EMAIL TEXT
        );
    ''');
    db.execute('''
        CREATE TABLE CUSTOMER_FUNCTION(
          FUNCTION_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          CATERER_ID TEXT,
          CUSTOMER_ID INTEGER,
          FUNCTION_NAME TEXT,
          ADDRESS TEXT,
          FAMILY_NAME TEXT,
          FUNCTION_TYPE,
          START_DATE TEXT,
          END_DATE TEXT         
        );
    ''');
    print("on create called");
  }

  static Future insertCustomer(Customer customer) async {
    Database db = await getDatabase;
    await db.insert(DB_TABLE_CUSTOMER, customer.toMap());
    print("recored inserted " + customer.toString());
  }

  static Future insertCustomerFunction(CustomerFunction function) async {
    Database db = await getDatabase;
    await db.insert(DB_TABLE_CUSTOMER, function.toMap());
    print("recored inserted " + function.toString());
  }
}
