import 'package:flutter/material.dart';

class ListExample extends StatefulWidget {
  @override
  State<ListExample> createState() => _ListExampleState();
}

class _ListExampleState extends State<ListExample> {
  TextEditingController titleController = TextEditingController();
  TextEditingController addtolistContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Add New List",
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
          SizedBox(
            height: 100,
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                border: OutlineInputBorder(),
                label: Text(
                  "Add to list",
                  style: TextStyle(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
            ),
          ),
        ]));
  }
}
