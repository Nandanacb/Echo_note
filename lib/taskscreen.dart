import 'package:echo_note/appwrite_service.dart';
import 'package:echo_note/edittask.dart';
import 'package:echo_note/class_task.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  late AppwriteService _appwriteService;
  late List<Task> _task;
  final DateTime dateTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
    _task = [];
    _loadtasks();
  }

  Future<void> _loadtasks() async {
    try {
      final tasks = await _appwriteService.getTasks();
      setState(() {
        _task = tasks.map((e) => Task.fromDocument(e)).toList();
      });
    } catch (e) {
      print("Title is empty");
    }
  }

  Future<void> _deleteTask(String taskId) async {
    try {
      await _appwriteService.deleteTask(taskId);
      _loadtasks();
    } catch (e) {
      print('Error deleting task:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7),
                  itemCount: _task.length,
                  itemBuilder: (context, index) {
                    final tasks = _task[index];
                    return Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(tasks.title),
                                Spacer(),
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'Edit') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Edittask(
                                                    id: 'id',
                                                    title: 'title',
                                                    description: 'description',
                                                  )));
                                    } else if (value == 'Delete') {}
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: "Edit", child: Text("Edit")),
                                    PopupMenuItem(
                                        value: 'Delete',
                                        child: GestureDetector(
                                            onTap: () => _deleteTask(tasks.id),
                                            child: Text('delete'))),
                                  ],
                                ),
                              ],
                            ),
                            Text(tasks.description),
                            Row(
                              children: [
                                Text(tasks.Date),
                                Text(tasks.Time),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
