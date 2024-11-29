import 'package:flutter/material.dart';

class Textscreen extends StatefulWidget {
  @override
  State<Textscreen> createState() => _TextscreenState();
}

class _TextscreenState extends State<Textscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("text screen")),
    );
  }
}
