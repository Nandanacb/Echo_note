import 'package:echo_note/appwrite_service.dart';
import 'package:echo_note/class_text.dart';

import 'package:echo_note/note.dart';
import 'package:echo_note/taskscreen.dart';
import 'package:echo_note/textscreen.dart';

import 'package:flutter/material.dart';

class Edittext extends StatefulWidget {
  @override
  State<Edittext> createState() => _EdittextState();
}

class _EdittextState extends State<Edittext> {
  late AppwriteService _appwriteService;
  late List<Textt> _textt;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
    _textt = [];
  }

  Future<void> _loadtextt() async {
    try {
      final textts = await _appwriteService.getTextts();
      setState(() {
        _textt = textts.map((e) => Textt.fromDocument(e)).toList();
      });
    } catch (e) {
      print('Title is empty');
    }
  }

  Future<void> _addTextt() async {
    final title = titleController.text;
    final description = contentController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        await _appwriteService.addTextt(
          title,
          description,
        );
        titleController.clear();
        contentController.clear();
        _loadtextt();
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
          "Edit Text",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TextScreen()));
            },
            child: IconButton(
                onPressed: _addTextt,
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
              controller: contentController,
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
          ],
        ),
      ),
    );
  }
}
