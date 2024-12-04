import 'package:echo_note/appwrite_service.dart';
import 'package:echo_note/classlist.dart';
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

 @override
  void initState(){
    super.initState();
    _appwriteService=AppwriteService();
    _lissts=[];
    
  }
 
  Future<void> _loadLissts() async {
    try {
      final lissts = await _appwriteService.getTasks();
      setState(() {
        _lissts = lissts.map((e) => Lisst.fromDocument(e)).toList();
      });
    } catch (e) {
      print('Title is empty');
    }
  }

  Future<void> _addLisst() async {
    final title = titleController.text;
    final description = addlistContoller.text;
    
    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        await _appwriteService.addLisst(title, description);
        titleController.clear();
        addlistContoller.clear();
        _loadLissts();
      } catch (e) {
        print('Error adding task:$e');
      }
    }
  }


 /*Future<void> _deletelisst(String lisstId) async {
    try {
      await _appwriteService.deleteLisst(lisstId);
      _loadLissts();
    } catch (e) {
      print('Error deleting task:$e');
    }
  }*/

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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Listscreen()));
                },
                icon: 
                IconButton(
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
                  suffixIcon: IconButton(onPressed: _addLisst, icon: Icon(Icons.add)),
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
             
             

            /*Expanded(
              
              child: ListView.builder(
                itemCount:_lissts.length ,
                itemBuilder: (context,index){
                  final lissts = _lissts[index];
                  return Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.pink),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lissts.addlist),
                        Spacer(),
                        IconButton(
                          onPressed: ()=> _deletelisst(lissts.id),
                          icon: Icon(Icons.delete))
                        
                      ],
                    ),
                  );
                }))*/
          ]),
        ),
        
        
        
        
        
        );
  }
}
