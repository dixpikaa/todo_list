import 'package:flutter/material.dart';

import 'todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  int id=0;

  void addTodo(Todo todo) {
    todo.id = id;
    id++;
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(int index, String newTodoTitle) {
    final todo  = _todos.firstWhere((e) => e.id == index);
    todo.title = newTodoTitle;
    notifyListeners();
  }

  // Added new comment

  // void updateTodo(Todo updatedTodo) {
  //   final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
  //   if (index != -1) {
  //     _todos[index] = updatedTodo;
  //     notifyListeners();
  //   }
  // }


  void deleteTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
