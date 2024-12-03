
import 'package:echo_note/appwrite_service.dart';
import 'package:echo_note/note.dart';
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
    _loadtask();
   
  }

  Future<void> _loadtask() async {
    try {
      final tasks = await _appwriteService.getTasks();
      setState(() {
        _task = tasks.map((e) => Task.fromDocument(e)).toList();
      });
    } catch (e) {
      print("Title is empty");
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
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7
                     ),
                  itemCount: _task.length,
                  itemBuilder: (context, index) {
                    final tasks = _task[index];
                    return Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tasks.title),
                            Text(tasks.description),
                            Row(
                              children: [
                                Text(tasks.Date),
                                Text(tasks.Time)
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