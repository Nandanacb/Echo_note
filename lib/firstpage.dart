import 'package:echo_note/listscreen.dart';
import 'package:echo_note/taskscreen.dart';
import 'package:echo_note/textscreen.dart';
import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget {
  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  bool _showicon = false;
  bool _showfab = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Echo Note",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          bottom: TabBar(tabs: [
            Text("Text"),
            Text("List"),
            Text("Task"),
          ]),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: TabBarView(children: [
            Textscreen(),
            Listscreen(),
            Taskscreen(),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Text(
              "+",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
