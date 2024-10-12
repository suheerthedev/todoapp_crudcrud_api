import 'dart:convert';
import 'package:todoapp_crudcrud_api/models/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoService {
  final String baseUrl = "https://crudcrud.com/api";
  final String apiKey = "7f38867300cc48f6890925da6152cf46";
  final String todoEndPoint = "todos";

  Future<List<TodoModel>> fetchTodos()async{
    final url = Uri.parse("$baseUrl/$apiKey/$todoEndPoint");
    final response = await http.get(url);
    final responseBody = jsonDecode(response.body);

    if(response.statusCode == 200){
      // return responseBody;
      List<TodoModel> todos = [];
      for(var eachItem in responseBody){
        todos.add(TodoModel.fromJson(eachItem));
      }
      return todos;
    }else{
      throw Exception("Failed To Fetch Tasks");
    }
  }

  Future createTodo(TodoModel todo) async{
    var url = Uri.parse("$baseUrl/$apiKey/$todoEndPoint");
    var response = await http.post(
      url, 
      headers: {"Content-Type": "application/json"},

      body: jsonEncode(todo.toJson()),
      );

      if(response.statusCode == 201){
        throw Exception("Failed to create task");
      }
    print('Response body: ${response.body}');
  }
}