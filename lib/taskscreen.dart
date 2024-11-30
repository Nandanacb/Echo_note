import 'package:flutter/material.dart';

class Taskscreen extends StatefulWidget {
  @override
  State<Taskscreen> createState() => _TaskscreenState();
}

class _TaskscreenState extends State<Taskscreen> {
  final DateTime datetime = DateTime.now();
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
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
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
          SizedBox(
            height: 100,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "Description",
                  style: TextStyle(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
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
          )
        ],
      ),
    );
  }
}
