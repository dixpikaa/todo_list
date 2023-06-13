import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todo_provider.dart';
import 'todo.dart';

void main() {
  

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoListScreen(),
      ),
    );
  }
}

class TodoListScreen extends StatelessWidget {

  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final todos = todoProvider.todos;

    return Scaffold(
        appBar: AppBar(
          title: Text('TODO Page'),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];

            return ListTile(
              title: Text(todo.title),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) =>
                              AlertDialog(
                                title: const Text("Alert Dialog Box"),
                                content: Column(
                                  children: [
                                    Text(
                                        "Update todo : ${todo.title}"),
                                    TextFormField(
                                      controller: editingController,
                                      decoration: InputDecoration(
                                        hintText: "${todo.title}",
                                        suffix: IconButton(onPressed: () {
                                          editingController.clear();
                                        }, icon:Icon(Icons.clear))

                                      ),

                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      todoProvider.updateTodo(index, editingController.text);
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("okay"),
                                    ),
                                  ),
                                ],
                              ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        todoProvider.deleteTodo(index);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTodoScreen()),
            );
          },
          child: Icon(Icons.add),
        ));
  }
}

class AddTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    TextEditingController _titleController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text('Add TODO'),
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      labelText: '  Write Your Todo',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      String title = _titleController.text;
                      if (title.isNotEmpty) {
                        Todo todo = Todo(
                          title: title,
                          isCompleted: false,
                        );
                        todoProvider.addTodo(todo);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Add ToDo"),
                  ),
                ),
              ],
            )));
  }
}

