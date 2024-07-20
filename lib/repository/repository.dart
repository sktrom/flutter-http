import 'package:flutter_http/models/todo.dart';

abstract class Repository {
  Future<List<Todo>> getTodoList();
  Future<String> patchTodoList(Todo todo);
  Future<String> postTodoList(Todo todo);
  Future<String> deleteTodoList(Todo todo);
  Future<String> putTodoList(Todo todo);
}
