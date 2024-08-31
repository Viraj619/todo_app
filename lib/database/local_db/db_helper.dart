
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/todo_model.dart';

class DbHelper{
  DbHelper._();
  static String TABLE_NOTE='note';
  static String COLUMN_NOTE_S_NO='s_no';
  static String COLUMN_NOTE_TITLE="title";
  static String COLUMN_NOTE_DESC="desc";
  static String COLUMN_NOTES_COMPLETED="completed";
  static String COLUMN_NOTES_CREATED_AT="created_at";

   static DbHelper getInstance()=>DbHelper._();

   Database? mDb;

   Future<Database> getDB()async{
     mDb??=await openDB();
     return mDb!;
   }

   Future<Database>openDB()async{
     /// create database
     Directory appDir= await getApplicationDocumentsDirectory();
     String dbPath=join(appDir.path,"notesDb.db");

     /// creating table database
     return await openDatabase(dbPath,onCreate: (db,version){
      db.execute("create table $TABLE_NOTE ( $COLUMN_NOTE_S_NO integer primary key autoincrement, $COLUMN_NOTE_TITLE text,$COLUMN_NOTE_DESC text,$COLUMN_NOTES_COMPLETED integer,$COLUMN_NOTES_CREATED_AT text )");
     },version: 1);

   }

   ///queries

      /// adding notes
  Future<bool>addTodo({required TodoModel newTodo})async{
     var mDb=await getDB();
     int rowEffected= await mDb.insert(TABLE_NOTE, newTodo.toMap());
     return rowEffected>0;
   }
   /// update notes
     Future<bool>update({required TodoModel updateTodo,required int sno})async{
     var mDb=await getDB();
     int rowEffected=await mDb.update(TABLE_NOTE, updateTodo.toMap(),where:"$COLUMN_NOTE_S_NO=?",whereArgs: [sno]);
     return rowEffected>0;
     }

     /// update checkbox
    Future<bool>updateCheckbox({required TodoModel updatedCheckbox,required int sno})async{
     var mDb=await getDB();
     int rowEffected=await mDb.update(TABLE_NOTE, updatedCheckbox.toMap(),where:"$COLUMN_NOTE_S_NO=?",whereArgs: [sno]);
     return rowEffected>0;
    }

       /// delete notes
   Future<bool> deleteNotes({required int sno})async{
     var mDb= await getDB();
     int rowEffected =await mDb.delete(TABLE_NOTE,where: "$COLUMN_NOTE_S_NO=?",whereArgs: ['$sno']);
     return rowEffected>0;
   }
   /// fetch notes
  Future<List<TodoModel>> fetchAllNotes()async{
     var mDb=await getDB();
    var data= await mDb.query(TABLE_NOTE);
    List<TodoModel> allTodo=[];
    for(Map<String,dynamic> eachData in data){
      allTodo.add(TodoModel.fromMap(eachData));
    }
    return allTodo;
  }




}