
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/todo_model.dart';
import 'package:to_do/todo_provider.dart';
import 'package:to_do/ui_helper.dart';

class DetailPage extends StatelessWidget{
  DateFormat mFormat= DateFormat.yMMMd();

  int sno;
  String title,desc;
  int dIndex;
  DetailPage({required this.sno,required this.title,required this.desc,required this.dIndex});

  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text=title;
    descController.text=desc;
    List<TodoModel>TodoNotes=context.watch<TodoProvider>().getAllTodo();
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xffF9EA85),
        leading:IconButton(onPressed:(){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,size: 30,)),
        actions: [
          TextButton(onPressed:(){
            context.read<TodoProvider>().update(TodoModel(title: titleController.text, desc:descController.text,created_At: TodoNotes[dIndex].created_At), sno);
            Navigator.pop(context);
          },child: Text("Save",style: mTextStyle16(),),),
          PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (_){
                return[
                  PopupMenuItem(child: Text("gvhvjb"))
                ];
              })
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(200,100),),
                color: Color(0xffF9EA85),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text("Edit if anything required",style: mTextStyle20(),),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Text("Date :",style: mTextStyle16(),),
                        SizedBox(width: 5,),
                        Text('${mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(TodoNotes[dIndex].created_At)))}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  TextField(
                    textAlign: TextAlign.center,
                    controller: titleController,
                    style: TextStyle(fontSize:20,decoration: TodoNotes[dIndex].completed==1?TextDecoration.lineThrough:TextDecoration.none),
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: descController,

                    style: TextStyle(decoration: TodoNotes[dIndex].completed==1?TextDecoration.lineThrough:TextDecoration.none),
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}