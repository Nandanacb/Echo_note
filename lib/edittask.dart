import 'package:echo_note/appwrite_service.dart';

import 'package:echo_note/class_task.dart';
import 'package:echo_note/taskscreen.dart';

import 'package:flutter/material.dart';

class Edittask extends StatefulWidget {
  final String id;
  final String title;
  final String description;

  const Edittask(
      {required this.id, required this.title, required this.description});

  @override
  State<Edittask> createState() => _EdittaskState();
}

class _EdittaskState extends State<Edittask> {
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
  }

  Future<void> _loadTasks() async {
    try {
      final tasks = await _appwriteService.getTasks();
      setState(() {
        _tasks = tasks.map((e) => Task.fromDocument(e)).toList();
      });
    } catch (e) {
      print('Title is empty');
    }
  }

  Future<void> _addTask() async {
    final title = titleController.text;
    final description = descriptionController.text;
    String date = "${datetime.day}/${datetime.month}/${datetime.year}";
    String time = "${datetime.hour}/${datetime.minute}";
    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        await _appwriteService.addTask(title, description, date, time);
        titleController.clear();
        descriptionController.clear();
        _loadTasks();
      } catch (e) {
        print('Error adding task:$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Edit Task",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TaskScreen()));
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
              maxLines: 20,
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
            SizedBox(
              height: 25,
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
          ],
        ),
      ),
    );
  }
}
