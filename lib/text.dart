import 'package:flutter/material.dart';

class TextExample extends StatefulWidget {
  @override
  State<TextExample> createState() => _TextExampleState();
}

class _TextExampleState extends State<TextExample> {
  
  TextEditingController titleController=TextEditingController();
  TextEditingController contentController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Add New Note",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ))
          ],
        ),
        body: Column(children: [
          SizedBox(height: 10),
          TextField(
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
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                "Content",
                style: TextStyle(color: Colors.green),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            ),
          ),
        ]));
  }
}
