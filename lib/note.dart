

import 'package:appwrite/models.dart';

class Task {
  final String id;
  final String title;
  final String description;

  Task({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Task.fromDocument(Document doc) {
    return Task(
      id: doc.$id,
      title: doc.data['title'],
      description: doc.data['description'],
    );
  }
}
