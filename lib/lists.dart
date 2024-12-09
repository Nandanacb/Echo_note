import 'package:echo_note/appwrite_service.dart';
import 'package:echo_note/class_list.dart';
import 'package:echo_note/listscreen.dart';
import 'package:flutter/material.dart';

class ListExample extends StatefulWidget {
  @override
  State<ListExample> createState() => _ListExampleState();
}

class _ListExampleState extends State<ListExample> {
  late AppwriteService _appwriteService;
  late List<Lisst> _lissts;

  TextEditingController titleController = TextEditingController();
  TextEditingController addlistContoller = TextEditingController();
  
  late List<String> add = [];

  void newList() {
    setState(() {
      if (addlistContoller.text.isNotEmpty) {
        add.add(addlistContoller.text);
        addlistContoller.clear();
      }
    });
  }


 List<Lisst>convertAddToLisst(){
  List<Lisst> newLisstItems=[];
  for(var item in add){
    newLisstItems.add(Lisst(title: item, id: 'id', addlist: 'addlist'));
  }
  return newLisstItems;
 }

  


Future<void> _addLisst() async {
    final title = titleController.text;
    final addlist=add;
    
    if (title.isNotEmpty && addlist.isNotEmpty) {
      try {

        List<Lisst> newLisstItems=convertAddToLisst();
        
        for(var lisstItem in newLisstItems){
        await _appwriteService.addLisst(title, addlist);
        }
        titleController.clear();
        addlistContoller.clear();
        setState(() {
          add.clear();
        });
        _loadLissts();
      } catch (e) {
        print('Error adding task:$e');
      }
    }
  }
  
  void _removeAdd(int index) {
    setState(() {
      add.removeAt(index);
    });
  }
 

  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
    _lissts = [];
    _addLisst();
  }

  Future<void> _loadLissts() async {
    try {
      final lissts = await _appwriteService.getLissts();
      setState(() {
        _lissts = lissts.map((e) => Lisst.fromDocument(e)).toList();
      });
    } catch (e) {
      print('Error loading tasks: $e');
    }
  }

  
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Listscreen(lissts: _lissts,)));
              },
              icon: IconButton(
                onPressed: _addLisst,
                
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(height: 10),
          TextField(
            controller: titleController,
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
              controller: addlistContoller,
              decoration: InputDecoration(
                suffixIcon:
                    IconButton(onPressed: newList, icon: Icon(Icons.add)),
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
          Expanded(
              child: ListView.builder(
                  itemCount: add.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(add[index]),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    _removeAdd(index);
                                  },
                                  child: Icon(Icons.cancel)),
                            ],
                          ),
                        ],
                      ),
                    );
                  }))
        ]),
      ),
    );
  }
}
