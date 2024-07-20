import 'package:flutter_http/models/todo.dart';
import 'package:flutter_http/repository/repository.dart';

class TodoController {
  final Repository repository;

  TodoController(this.repository);

  Future<List<Todo>> fetchTodoList() async {
    return repository.getTodoList();
  }

  Future<String> upDatePatchComplet(Todo todo) async {
    return repository.patchTodoList(todo);
  }

  Future<String> upDatePutComplet(Todo todo) async {
    return repository.putTodoList(todo);
  }

  Future<String> deleteTodoListCom(Todo todo) async {
    return repository.deleteTodoList(todo);
  }

  Future<String> postTodoListCom(Todo todo) async {
    return repository.postTodoList(todo);
  }
}


// mustafaaobilal@gmail.com
// ddj728DMMXlc@@