import 'package:echo_note/class_list.dart';

import 'package:flutter/material.dart';

class Listscreen extends StatefulWidget {
  final List<Lisst> lissts;

  Listscreen({required this.lissts});

  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    // final lisst = widget.lissts[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 69, 48, 183)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                //Text(lisst.title),
                                Spacer(),
                                PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == 'Edit') {
                                      } else if (value == 'Delete') {}
                                    },
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                              value: "Edit",
                                              child: Text("Edit")),
                                          PopupMenuItem(
                                              value: 'Delete',
                                              child: Text('delete')),
                                        ])
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
