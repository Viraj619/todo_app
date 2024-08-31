
import 'package:to_do/database/local_db/db_helper.dart';

class TodoModel{
 int? sno;
 String title;
 String desc;
 int completed;
 String created_At;
 TodoModel({this.sno,required this.title,required this.desc,this.completed=0,required this.created_At});

 /// model
 factory TodoModel.fromMap(Map<String,dynamic>map){
   return TodoModel(sno:map[DbHelper.COLUMN_NOTE_S_NO],
       title:map[DbHelper.COLUMN_NOTE_TITLE],
       desc:map[DbHelper.COLUMN_NOTE_DESC],
       completed:map[DbHelper.COLUMN_NOTES_COMPLETED],
      created_At: map[DbHelper.COLUMN_NOTES_CREATED_AT]);

 }
 /// map
Map<String,dynamic>toMap(){
   return{
     DbHelper.COLUMN_NOTE_TITLE:title,
     DbHelper.COLUMN_NOTE_DESC:desc,
     DbHelper.COLUMN_NOTES_COMPLETED:completed,
     DbHelper.COLUMN_NOTES_CREATED_AT:created_At,
   };
}
}