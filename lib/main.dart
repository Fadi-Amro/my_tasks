import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Task {
  final String title;
  bool isCompleted;

  Task(this.title, {this.isCompleted = false});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskListPage(),
    );
  }
}
class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final List<Task> tasks = [
    Task('Study Flutter-slides'),
    Task('Read a book'),
    Task('Finish assignment'),
    Task('Go shopping'),
  ];

  @override
  Widget build(BuildContext context) {
    final completedTasks =
        tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),
      body: Column(
        children: [
          Text(
            'Completed: ${completedTasks.length} / ${tasks.length}',
            style: const TextStyle(fontSize: 22),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  task: tasks[index],
                  onChanged: (value) {
                    setState(() {
                      tasks[index].isCompleted = value!;
                    });
                  },
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => CompletedTasksPage(
                    tasks: completedTasks,
                  ),
                ),
              );
            },
            child: const Text('View Completed Tasks'),
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  final void Function(bool?) onChanged;

  const TaskItem({
    super.key,
    required this.task,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: onChanged,
      ),
    );
  }
}

class CompletedTasksPage extends StatelessWidget {
  final List<Task> tasks;

  const CompletedTasksPage({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  trailing: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}