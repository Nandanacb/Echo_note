import 'package:echo_note/appwrite_service.dart';
import 'package:echo_note/classlist.dart';
import 'package:echo_note/edittask.dart';

import 'package:flutter/material.dart';

class Listscreen extends StatefulWidget {
  const Listscreen({super.key});

  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController addlistcontroller = TextEditingController();
  late AppwriteService _appwriteService;
  late List<Lisst> _lissts;
  
  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
    _lissts = [];
    _loadLissts();
  }

  Future<void> _loadLissts() async {
    try {
      final lissts = await _appwriteService.getTasks();
      setState(() {
        _lissts = lissts.map((e) => Lisst.fromDocument(e)).toList();
      });
    } catch (e) {
      print("Title is empty");
    }
  }

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
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7),
                  itemCount: _lissts.length,
                  itemBuilder: (context, index) {
                    final lissts = _lissts[index];
                    return Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(lissts.title),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      
                                    },
                                    child: Icon(Icons.menu_outlined))
                              ],
                            ),
                            Text(lissts.addlist),
                            
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
