import 'package:echo_note/appwrite_service.dart';
import 'package:echo_note/class_list.dart';

import 'package:flutter/material.dart';

class Listscreen extends StatefulWidget {
  
  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
  
  late AppwriteService _appwriteService;
  late List<Lisst> _lissts;

 @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
    _lissts = [];
    _loadLissts();  
    // Ensure this is called to load the data when the screen initializes
  }
  Future<void> _loadLissts() async {
    try {
      final lissts = await _appwriteService.getLissts();
      setState(() {
        _lissts = lissts.map((e) => Lisst.fromDocument(e)).toList();
      });
    } catch (e) {
      print('Error loading lists: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: /*_lissts.isEmpty
          ? Center(child: Text("no data"))
          :*/ Column( 
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7),
                  
                   itemCount: _lissts.length,
                  itemBuilder: (context, index) {
                    final lisst = _lissts[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                      
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 69, 48, 183)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(lisst.title, style: TextStyle(color: Colors.white)),
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
                                      ]),
                                      
                                ],
                              ),
                                    SizedBox(height: 10),
                                    // Display the items in addlist
                                    ...lisst.addlist.map((item) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(item, style: TextStyle(color: Colors.white)),
                                    )).toList(),
                             
                            ],
                          ),
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
