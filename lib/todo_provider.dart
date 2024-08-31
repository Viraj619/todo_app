
import 'package:flutter/widgets.dart';
import 'package:to_do/database/local_db/db_helper.dart';
import 'package:to_do/todo_model.dart';

class TodoProvider extends ChangeNotifier{
  DbHelper dbHelper;

  TodoProvider({required this.dbHelper});

  List<TodoModel>listTodo=[];

  /// events


  ///  addTodo
 void add( TodoModel newNotes)async{
   bool check=await dbHelper.addTodo(newTodo: newNotes);
   if(check){
     listTodo=await dbHelper.fetchAllNotes();
     notifyListeners();
   }
 }
 /// updateTodo
 void update(TodoModel update,int sno)async {
   bool check = await dbHelper.update(updateTodo: update, sno: sno);
   if (check) {
     listTodo = await dbHelper.fetchAllNotes();
     notifyListeners();
   }
 }
   /// updateCheckbox
   void upDateCheckbox({required TodoModel updatedCheckbox,required int sno})async{
     bool check=await dbHelper.updateCheckbox(updatedCheckbox: updatedCheckbox, sno: sno);
     if(check){
       listTodo=await dbHelper.fetchAllNotes();
       notifyListeners();
     }
   }/// deleteTodo
 void delete(int sno)async{
   bool check =await dbHelper.deleteNotes(sno: sno);
   if(check){
     listTodo=await dbHelper.fetchAllNotes();
     notifyListeners();
   }
 }

 /// initialTodo
 void getInitial()async{
   listTodo=await dbHelper.fetchAllNotes();
   notifyListeners();
 }
 /// getTodo
 List<TodoModel> getAllTodo()=>listTodo;

}