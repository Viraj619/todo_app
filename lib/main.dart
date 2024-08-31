
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/database/local_db/db_helper.dart';
import 'package:to_do/detail_page.dart';
import 'package:to_do/home_page.dart';
import 'package:to_do/todo_provider.dart';

void main(){
runApp(MultiProvider(providers: [
  ChangeNotifierProvider(create: (context) => TodoProvider(dbHelper:DbHelper.getInstance()),)
],child: MainApp()));
}

class MainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}