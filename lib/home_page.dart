
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/database/local_db/db_helper.dart';
import 'package:to_do/detail_page.dart';
import 'package:to_do/todo_model.dart';
import 'package:to_do/todo_provider.dart';
import 'package:to_do/ui_helper.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>HomeState();
}
class HomeState extends State<HomePage>{
  //static DbHelper mDb=DbHelper.getInstance();
  TextEditingController titleController= TextEditingController();
  TextEditingController descController=TextEditingController();
 // List<Map<String,dynamic>> TodoNotes=[];
  bool select=false;

  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().getInitial();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
           Container(
             width: 550,
             height: 300,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(200,110),),
               color: Color(0xffF9EA85),
             ),
           ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    IconButton(onPressed: (){
                
                    }, icon: Icon(Icons.dehaze_rounded,color: Colors.black,size: 30,)),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                
                        Column(
                          children: [
                            /// login name
                            Text("Hollo \$name",style: mTextStyle20(),),
                            Text("Daily tasks",style: mTextStyle15(mFontWeigh: FontWeight.normal),),
                          ],
                        ),
                        SizedBox(width: 160,),
                        /// image
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image:  NetworkImage("https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=300"),
                              fit: BoxFit.cover),)
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child:Consumer<TodoProvider>(builder: (_,provider,__){
                        List<TodoModel>TodoNotes=provider.getAllTodo();
                        return  Container(
                          width: double.infinity,
                          height: 600,
                          child: ListView.builder(
                              itemCount:TodoNotes.length,
                              itemBuilder: (_,index){
                                return Stack(
                                  children: [
                                    Container(
                                      height:150,
                                      color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
                                      margin: EdgeInsets.all(11),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(sno: TodoNotes[index].sno!, title: TodoNotes[index].title, desc:TodoNotes[index].desc,dIndex: index,),));
                                        },
                                        child: Card(
                                            margin: EdgeInsets.all(20),
                                            elevation: 6,
                                            color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
                                            child: Column(
                                              children: [
                                                CheckboxListTile(
                                                  controlAffinity: ListTileControlAffinity.leading,
                                                  title:Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width:100,
                                                          height: 50,
                                                          child: Text(TodoNotes[index].title,style: TextStyle(decoration: TodoNotes[index].completed==1?TextDecoration.lineThrough : TextDecoration.none),)),
                                                           IconButton(onPressed: (){
                                                            context.read<TodoProvider>().delete(TodoNotes[index].sno!);
                                                            }, icon: Icon(Icons.delete,size: 20,)),
                                                    ],
                                                  ),
                                                  value:TodoNotes[index].completed==1,
                                                  onChanged: (value){
                                                    /// update todo
                                                    var updatedTodo=TodoModel(sno:TodoNotes[index].sno,title:TodoNotes[index].title, desc: TodoNotes[index].desc,completed: value! ? 1 : 0,created_At: TodoNotes[index].created_At);
                                                    provider.upDateCheckbox(updatedCheckbox: updatedTodo, sno:TodoNotes[index].sno!);
                                                  },),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        );
                      },)
                    )
                
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Color(0xffF9EA85),
        onPressed: (){
          showModalBottomSheet(context: context, builder: (context){
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.yellow,Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                border: Border.all(color: Colors.yellow,
                width: 4)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text("Add Task",style: mTextStyle20(),),
                    SizedBox(height: 20,),
                    /// title
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                      ),
                      child: TextField(
                        controller:titleController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "New Task",
                          hintText:'Enter Task',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.black)
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(color: Colors.black)
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    /// desc
                    Container(
                      width: 300,
                      height: 200,
                      child: TextField(
                        textAlign: TextAlign.start,
                        maxLines:10,
                        controller:descController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: " Enter Notes",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.black)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(color: Colors.black)
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: ()async{
                          context.read<TodoProvider>().add(TodoModel(title: titleController.text, desc: descController.text,created_At:DateTime.now().millisecondsSinceEpoch.toString()));
                          titleController.clear();
                          descController.clear();
                          Navigator.pop(context);
                        }, style: TextButton.styleFrom(backgroundColor: Color(0xfFFF498),side: BorderSide(color: Colors.black)),child:Text("add",style: mTextStyle20(mFontWeight: FontWeight.normal),) ),
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        },style: TextButton.styleFrom(backgroundColor: Color(0xfFFF498),side: BorderSide(color: Colors.black)),child: Text("Cancel",style: mTextStyle20(mFontWeight: FontWeight.normal),))
                      ],
                    )

                  ],
                ),
              ),
            );
          });
        },child: Icon(Icons.add),
      ),
    );
  }
}