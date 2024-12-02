import 'package:flutter/material.dart';

class Listscreen extends StatefulWidget {
  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
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
