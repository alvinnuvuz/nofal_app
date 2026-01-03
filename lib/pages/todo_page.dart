import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> todos = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  Future<void> loadTodos() async {
    setState(() => isLoading = true);
    final data = await TodoService.getTodos();
    setState(() {
      todos = data;
      isLoading = false;
    });
  }

  void showTodoDialog({Todo? todo}) {
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descController = TextEditingController(text: todo?.description ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(todo == null ? "Tambah Todo" : "Edit Todo"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Judul"),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: "Deskripsi"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isEmpty) return;

              bool success;
              if (todo == null) {
                success = await TodoService.addTodo(
                  title: titleController.text,
                  description: descController.text,
                );
              } else {
                success = await TodoService.updateTodo(
                  id: todo.id,
                  title: titleController.text,
                  description: descController.text,
                );
              }

              if (success) {
                Navigator.pop(context);
                loadTodos();
              }
            },
            child: Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) async {
                      await TodoService.toggleComplete(todo.id, value ?? false);
                      loadTodos();
                    },
                  ),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: todo.description != null
                      ? Text(todo.description!)
                      : null,
                  onTap: () => showTodoDialog(todo: todo),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await TodoService.deleteTodo(todo.id);
                      loadTodos();
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showTodoDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
