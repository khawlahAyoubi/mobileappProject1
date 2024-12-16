import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskly',
      home: TaskPage(),
    );
  }
}

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Task> tasks = [];

  TextEditingController taskController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  void _addTask(String task, String note) {
    setState(() {
      tasks.add(Task(task, note, false));
    });
    taskController.clear();
    noteController.clear();
  }

  void _edit(int n, String NewTask, String NewNote) {
    setState(() {
      tasks[n].task = NewTask;
      tasks[n].note = NewNote;
    });
  }

  void _deleteTask(int n) {
    setState(() {
      tasks.removeAt(n);
    });
  }

  void _TaskCompletion(int com) {
    setState(() {
      tasks[com].isCompleted = !tasks[com].isCompleted;
    });
  }

  void _AddTask() {
    taskController.clear();
    noteController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('new task'),
          backgroundColor: Colors.purple[100],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(hintText: 'Add Task'),
              ),
              TextField(
                controller: noteController,
                decoration: InputDecoration(hintText: 'Add Note'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty && noteController.text.isNotEmpty) {
                  _addTask(taskController.text, noteController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('add'),
            ),
          ],
        );
      },
    );
  }

  void _EditTask(int index) {
    taskController.text = tasks[index].task;
    noteController.text = tasks[index].note;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(hintText: 'Edit Task'),
              ),
              TextField(
                controller: noteController,
                decoration: InputDecoration(hintText: 'Edit Note'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty && noteController.text.isNotEmpty) {
                  _edit(index, taskController.text, noteController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('edit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taskly'),
        centerTitle: true,
        backgroundColor: Colors.purple[200],
      ),
      body:

      ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, n) {
          final task = tasks[n];
          return ListTile(
            title: Text(task.task),
            subtitle: Text('Note: ${task.note}'),
            leading: Checkbox(
              shape: CircleBorder(),
              activeColor: Colors.purple[200],
              checkColor: Colors.white,
              value: task.isCompleted,
              onChanged: (_) {
                _TaskCompletion(n);
              },
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.purple[200],

                  onPressed: () {
                    _EditTask(n);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.purple[200],
                  onPressed: () {
                    _deleteTask(n);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        splashColor: Colors.purple[100],
        onPressed: _AddTask,
        child: Icon(Icons.add),
        foregroundColor: Colors.purple[300],
      ),
    );
  }
}

class Task {
  String task;
  String note;
  bool isCompleted;

  Task(this.task, this.note, this.isCompleted);
}
