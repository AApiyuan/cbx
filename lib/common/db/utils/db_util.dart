part of '../sql_db.dart';

class DbUtil {

  static int openCount = 0;

  // 获取数据库中所有的表
  static Future<List<String>> getTables() async {
    if (db == null) {
      return Future.value([]);
    }
    List tables = await db!.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item) {
      targetList.add(item['name']);
    });
    print(tables);
    return targetList;
  }

  // 检查数据库中, 表是否完整, 在部份android中, 会出现表丢失的情况
  static Future checkTableIsRight() async {
    List<String> expectTables = ['customer', 'goods', 'discount','pull_log','config','remit','hang_order']; //将项目中使用的表的表名添加集合中

    List<String> tables = await getTables();

    for (int i = 0; i < expectTables.length; i++) {
      if (!tables.contains(expectTables[i])) {
        return false;
      }
    }
    return true;
  }

  //初始化数据库
  static Future init() async {
    //Get a location using getDatabasesPath
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'data.db');
    // print(path);
    try {
      db = await openDatabase(path);
    } catch (e) {
      print("error $e");
    }

    bool tableIsRight = await checkTableIsRight();

    if (!tableIsRight) {
      // 关闭上面打开的db，否则无法执行open
      db!.close();
      //表不完整
      // Delete the database
      await deleteDatabase(path);

      db = await openDatabase(path, version: 9, onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(SqlTable.sql_createTable_customer);
        await db.execute(SqlTable.sql_createTable_goods);
        await db.execute(SqlTable.sql_createTable_discount);
        await db.execute(SqlTable.sql_createTable_pull_log);
        await db.execute(SqlTable.sql_createTable_remit);
        await db.execute(SqlTable.sql_createTable_config);
        await db.execute(SqlTable.sql_createTable_hang_order);
        await db.execute(SqlTable.sql_createTable_dept);
        print('db created version is $version');
      }, onOpen: (Database db) async {
        print('new db opened');
      });
      db!.close();
    } else {
      db!.close();
      print("existing database");
    }

  }

  static Future open() async {
    openCount++;
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'data.db');
    try {
      db = await openDatabase(path);
    } catch (e) {
      print('DBUtil open() Error $e');
    }
  }

  static Future close() async {
    if (--openCount != 0) return;
    await db!.close();
  }
}
