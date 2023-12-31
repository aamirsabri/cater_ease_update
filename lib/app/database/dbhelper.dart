import 'package:cater_ease/app/constants.dart';
import 'package:cater_ease/model/customer_model.dart';
import 'package:cater_ease/model/event_master.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../model/customer_function_model.dart';

const String DB_NAME = "cater_ease.db";
const String DB_TABLE_CUSTOMER = "customer";
const String DB_TABLE_CATERER = "caterer";
const String DB_TABLE_CUSTOMER_FUNCTION = "customer_function";
const String DB_TABLE_EVENT_MASTER = "event_master";

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
          FUNCTION_TYPE TEXT,
          START_DATE TEXT,
          END_DATE TEXT         
        );
    ''');
    db.execute('''
        CREATE TABLE EVENT_MASTER(
          EVENT_MASTER_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          CATERER_ID TEXT,
          EVENT_NAME TEXT,
          EVENT_DESCRIPTION TEXT,
          EVENT_ICON TEXT             
        );
    ''');
    print("on create called");
  }

  static Future<List<CustomerFunction>> getFutureCustomerFunctions() async {
    List<CustomerFunction> functions = [];
    Database db = await getDatabase;
    List<Map<String, dynamic>> results =
        await db.rawQuery("SELECT * FROM " + DB_TABLE_CUSTOMER_FUNCTION);
    for (var result in results) {
      print(result.toString());
      functions.add(CustomerFunction.fromMap(result));
    }

    return functions;
  }

  static Future<CustomerFunction?> getCustomerFunctionByFunctionId(
      customerId, functionId) async {
    Database db = await getDatabase;
    List<Map<String, dynamic>> functions = await db.rawQuery("SELECT * FROM " +
        DB_TABLE_CUSTOMER_FUNCTION +
        " WHERE " +
        DBConstant.CUSTOMER_ID +
        "=" +
        customerId.toString() +
        " AND " +
        DBConstant.FUNCTION_ID +
        "=" +
        functionId.toString());
    if (functions.isNotEmpty) {
      return CustomerFunction.fromMap(functions[0]);
    }
    return null;
  }

  static Future<Customer> getCustomerFromId(int customerId) async {
    Database db = await getDatabase;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM " +
        DB_TABLE_CUSTOMER +
        " WHERE " +
        DBConstant.CUSTOMER_ID +
        "=" +
        customerId.toString());

    return Customer.fromMap(result[0]);
  }

  static Future<dynamic> insertCustomer(Customer customer) async {
    Database db = await getDatabase;
    final res = await db.insert(DB_TABLE_CUSTOMER, customer.toMap());
    print("recored inserted " + customer.toString() + " res " + res.toString());
    return res;
  }

  static Future<dynamic> insertEventMaster(EventMaster eventMaster) async {
    Database db = await getDatabase;
    final res = await db.insert(DB_TABLE_EVENT_MASTER, eventMaster.toMap());
  }

  static Future insertCustomerFunction(CustomerFunction function) async {
    Database db = await getDatabase;
    final res = await db.insert(DB_TABLE_CUSTOMER_FUNCTION, function.toMap());

    print("recored inserted " + function.toString() + " res " + res.toString());
    return res;
  }

  static Future<Map<String, Customer>> getAllCustomers() async {
    Map<String, Customer> customers = {};
    Database db = await getDatabase;
    List<Map<String, dynamic>> results = await db.query(DB_TABLE_CUSTOMER);
    print("all consumer " + results.toString());
    for (var result in results) {
      customers[result[DBConstant.CUSTOMER_MOBILE]] = Customer.fromMap(result);
    }
    return customers;
  }
}
