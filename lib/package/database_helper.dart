import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/note.dart';

class Dbhelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "notes.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE YourNote(title TEXT,content TEXT)");
    print("table created");
  }

  Future<List<YourNote>> getNotes() async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM YourNote');
    
    List<YourNote> yournotes = new List();
    if(list.length !=null){
    for(var i=0;i<(list.length);i++)
    {
      yournotes.add(YourNote(list[i]["title"],list[i]["content"]));
    }
    }

   
    return yournotes;

  }
  void updateNotes(orgtitle,newtitle,newcontent)async{
    var dbClient = await db;
    await dbClient.transaction((txn)async{
      return await txn.rawUpdate(
    'UPDATE YourNote SET title = ?, content = ? WHERE title = ?',
    ['$newtitle', '$newcontent', '$orgtitle']);
    });
  }
  void deleteNotes(title)async{
    var dbClient = await db;
    await dbClient.transaction((txn)async{
      return await txn.rawDelete(
    'DELETE FROM YourNote  WHERE title = ?',
    ['$title']);
    });
  }

  void saveNotes(YourNote yournote)async{
    var dbClient = await db;
    await dbClient.transaction((txn)async{
      return await txn.rawInsert('INSERT INTO YourNote(title,content) VALUES('+'\''+ yournote.title +'\''+','+'\''+ yournote.content +'\''+')');
    });
  }
}
