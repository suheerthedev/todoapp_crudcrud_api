import 'package:flutter/material.dart';
import 'package:todoapp_crudcrud_api/models/todo_model.dart';
import 'package:todoapp_crudcrud_api/services/todo_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService todoService = TodoService();
  final TextEditingController _titleCont = TextEditingController();
  final TextEditingController _priorityCont =TextEditingController();

  void deleteTask(){}

   void addTodo() async{
    final todo = TodoModel(
      title: _titleCont.text, 
      priority: int.parse(_priorityCont.text), 
      isCompleted: false);

      try{
        await todoService.createTodo(todo);
        setState(() {
          todoService.fetchTodos();
        });
      }catch (error){
        print(error);
      }
  }

  showPostDialog(){
    showDialog(context: context, builder: (context) {
      return  AlertDialog(
        title: const Text("Add a new task"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Title"
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Priority 1/2/3/4"
              ),
            )
          ],
        ),
        actions: [
          
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: (){
                Navigator.pop(context);
              },  
              child:const Text("Cancel")),
              ElevatedButton(
                onPressed: (){
                Navigator.pop(context);
              },  
              child:const Text("Add")),
            ],
          )
        ],
      );
    },);
  }

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: FutureBuilder(future: todoService.fetchTodos(), builder: (context, snapshot){
          
          return ListView.builder(
            
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context,index){
              var todoElement = snapshot.data?[index]; 
              String? taskTitle = todoElement?.title;
              bool? taskStatus = todoElement?.isCompleted;
              int? taskPriority = todoElement?.priority;

              return Padding(
      padding: const EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.red,
            onPressed: (value){
              deleteTask();
            },
            icon: Icons.delete,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.white,
            onPressed: (value){
              deleteTask();
            },
            icon: Icons.edit,
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 0, 35, 150), Colors.blue],
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Checkbox(
                  activeColor: Colors.white,
                  checkColor: Colors.black,
                  side: const BorderSide(color: Colors.white, width: 1.5),
                  value: taskStatus,
                  onChanged: (value){
                    taskStatus = !taskStatus!;
                    
                  }),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskTitle ?? "No Title Available",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          decoration: taskStatus!
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationThickness: 1.5,
                          decorationColor: Colors.white),
                    ),
                    Text(
                      taskPriority == 1 ? "Most Important" : taskPriority == 2 ? "Important" : taskPriority == 3 ? "Normal" : "Least Important",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          decoration: taskStatus!
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationThickness: 1.5,
                          decorationColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
            });
        }) 
      ),
      floatingActionButton: FloatingActionButton(onPressed: showPostDialog, child: Icon(Icons.add),),
    );
  }
}