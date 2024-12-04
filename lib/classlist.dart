import 'package:appwrite/models.dart';

class Lisst {
  final String id;
  final String title;
  final String addlist;

  Lisst({
    required this.id,
    required this.title,
    required this.addlist,
  });

  factory Lisst.fromDocument(Document doc) {
    return Lisst(
      id: doc.$id,
      title: doc.data['title'],
      addlist: doc.data['addlist'],
    );
  }
}
