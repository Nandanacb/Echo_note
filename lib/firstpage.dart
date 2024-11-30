import 'dart:math';

import 'package:echo_note/listscreen.dart';
import 'package:echo_note/taskscreen.dart';
import 'package:echo_note/textscreen.dart';
import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget {
  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  bool _showicons = false;
  bool _showfab = true;

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
            floatingActionButton: _showfab
                ? FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _showicons = true;
                        _showfab = false;
                      });
                    },
                    child: Text(
                      "+",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))
                : null,
            body: Stack(children: <Widget>[
              if (_showicons)
                Positioned(
                  bottom: 80, // Adjust position above FAB
                  right: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 50),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskscreen()));
                          },
                          icon: Icon(Icons.add_task),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Listscreen()));
                          },
                          icon: Icon(Icons.check_box_rounded),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Textscreen()));
                          },
                          icon: Icon(Icons.menu),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
            ])));
  }
}
