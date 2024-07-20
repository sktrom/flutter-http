import 'dart:convert';
import 'dart:developer';

import 'package:flutter_http/models/todo.dart';
import 'package:flutter_http/repository/repository.dart';
import 'package:http/http.dart' as http;

class TodoRepository implements Repository {
  String baseURL = 'https://jsonplaceholder.typicode.com';

  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> todoList = [];
    var url = Uri.parse("$baseURL/todos");
    var response = await http.get(url);
    log(response.statusCode.toString(), name: 'Status Code in General: ');

    var responsBody = jsonDecode(response.body);
    for (var i = 0; i < responsBody.length; i++) {
      todoList.add(Todo.fromJson(responsBody[i]));
    }
    return todoList;
  }

  @override
  Future<String> patchTodoList(Todo todo) async {
    var url = Uri.parse("$baseURL/todos/${todo.id}");
    String responseData = '';
    await http.patch(
      url,
      body: {'completed': todo.completed.toString()},
      headers: {'Authorization': 'your_token'},
    ).then((response) {
      Map<String, dynamic> result = jsonDecode(response.body);
      log(result.toString(),name: 'Patch: ');
      return responseData = result['completed'].toString();
    });
    return responseData;
  }

  @override
  Future<String> putTodoList(Todo todo) async {
    var url = Uri.parse("$baseURL/todos/${todo.id}");
    String responseData = '';
    await http.put(
      url,
      body: {'completed': todo.completed.toString()},
      headers: {'Authorization': 'your_token'},
    ).then((response) {
      Map<String, dynamic> result = jsonDecode(response.body);
      log(result.toString(),name: 'Put: ');
      return responseData = result['completed'].toString();
    });

    return responseData;
  }

  @override
  Future<String> postTodoList(Todo todo)async {
   var url=Uri.parse('$baseURL/todos/');
  var response= await http.post(url,body: todo.toJson());
  log(response.body.toString(),name: 'Post: ');
  log(response.statusCode.toString(),name: 'Post Status Code: ');
  return 'true';
  }

  @override
  Future<String> deleteTodoList(Todo todo) async {
    var url = Uri.parse("$baseURL/todos/${todo.id}");
    var result = 'false';
    await http.delete(url).then((value) {
      log(value.body.toString(),name: 'Delete: ');
      log( todo.id.toString(),name: 'You Deleted Item Of Id: ');
      return result = 'true';
    });

    return result;
  }
}
