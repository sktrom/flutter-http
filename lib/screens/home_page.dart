import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_http/controller/todo_controller.dart';
import 'package:flutter_http/models/todo.dart';
import 'package:flutter_http/repository/todo_repository.dart';

class HomePagee extends StatelessWidget {
  const HomePagee({super.key});

  @override
  Widget build(BuildContext context) {
    var todoController = TodoController(TodoRepository());

    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API'),
      ),
      body: FutureBuilder(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('We Have Error'),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1, child: Text('${snapshot.data![index].id}')),
                    Expanded(
                        flex: 2, child: Text('${snapshot.data![index].title}')),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              todoController
                                  .upDatePatchComplet(snapshot.data![index])
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(milliseconds: 700),
                                    content: Text(value),
                                  ),
                                );
                              });
                            },
                            child: buildCall(
                              'patch',
                              const Color(0xffffe0b2),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              todoController
                                  .upDatePutComplet(snapshot.data![index]);
                            },
                            child: buildCall(
                              'put',
                              const Color(0xFFE1BEE7),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              todoController
                                  .deleteTodoListCom(snapshot.data![index])
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(milliseconds: 700),
                                    content: Text(value),
                                  ),
                                );
                              });
                            },
                            child: buildCall(
                              'delet',
                              const Color(0xFFFFCDD2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 0.5,
                height: 0.5,
              );
            },
            itemCount: snapshot.data?.length ?? 0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Todo todo=Todo(userId: 3112,id: 2121212,title: 'ksdsjfkfJ',completed: false);
          todoController.postTodoListCom(todo);
          log('Succses Add Post');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Container buildCall(String title, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(title)),
    );
  }
}
