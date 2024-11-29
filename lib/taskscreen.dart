import 'package:flutter/material.dart';

class Taskscreen extends StatefulWidget {
  @override
  State<Taskscreen> createState() => _TaskscreenState();
}

class _TaskscreenState extends State<Taskscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("task screen")),
    );
  }
}
