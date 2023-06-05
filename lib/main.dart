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
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final todos = todoProvider.todos;

    return Scaffold(
      appBar: AppBar(
        title: Text('TODO Page'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];

          return ListTile(
            title: Text(todo.title),
            trailing: Checkbox(
              value: todo.isCompleted,
              onChanged: (value) {
               final updatedTodo = Todo(
                  id: todo.id,
                  title: todo.title,
                  isCompleted: value ?? false,
                );
                IconButton(onPressed: (){}, icon: Icon(Icons.update)
          ,);
                todoProvider.updateTodo(updatedTodo);
              },

            ),
            onLongPress: () {
              todoProvider.deleteTodo(index);
            },
          );
        },
      ),
      floatingActionButton : 
      FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );
        },
        child: Icon(Icons.add),)
    );
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
                border:OutlineInputBorder(borderRadius:BorderRadius.circular(20))
              ),
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
                
                }, child: Text("Add ToDo"),     
                     ),
            ),
          ],
      )
      )
        );
        
              }
}
class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(


    );
  }
}
