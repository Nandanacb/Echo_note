import 'package:echo_note/appwrite_service.dart';
import 'package:echo_note/firstpage.dart';
import 'package:echo_note/note.dart';
import 'package:flutter/material.dart';

class Taskscreen extends StatefulWidget {
  @override
  State<Taskscreen> createState() => _TaskscreenState();
}

class _TaskscreenState extends State<Taskscreen> {
  late AppwriteService _appwriteService;
  late List<Task> _tasks;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final DateTime datetime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
    _tasks = [];
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final tasks = await _appwriteService.getTasks();
      setState(() {
        _tasks = tasks.map((e) => Task.fromDocument(e)).toList();
      });
    } catch (e) {
      print('Error loading tasks');
    }
  }

  Future<void> _addTask() async {
    final title = titleController.text;
    final description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        await _appwriteService.addTask(title, description);
        titleController.clear();
        descriptionController.clear();
        _loadTasks();
      } catch (e) {
        print('Error adding task:$e');
      }
    }
  }

  Future<void> _deleteTask(String taskId) async {
    try {
      await _appwriteService.deleteTask(taskId);
      _loadTasks();
    } catch (e) {
      print('Error deleting task:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Add New Task",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Firstpage()));
            },
            child: IconButton(
                onPressed: _addTask,
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "Title",
                  style: TextStyle(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green))),
          ),
          SizedBox(height: 10),
          TextField(
            maxLines: 22,
            controller: descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                "Description",
                style: TextStyle(color: Colors.green),
              ),
              alignLabelWithHint: true,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            ),
          ),
          Row(
            children: [
              Text(
                "${datetime.day.toString()}/${datetime.month.toString()}/${datetime.year.toString()}",
                style: TextStyle(color: Colors.green),
              ),
              Spacer(),
              Text(
                "${datetime.hour.toString()}/${datetime.minute.toString()}",
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          /*ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final tasks = _tasks[index];
                return Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 214, 108, 144)),
                  child: Column(
                    children: [
                      Text(tasks.title),
                      Text(tasks.description),
                    ],
                  ),
                );
              })*/
        ],
      ),
    );
  }
}
