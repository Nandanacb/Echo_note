import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteService {
  late Client client;
  late Databases databases;

  static const endpoint = "https://cloud.appwrite.io/v1";
  static const projectId = "674d5517000114a2fc41";
  static const databaseId = "674d55750023577ccc13";
  static const collectionId = "674d5596002c7f25de81";

  AppwriteService() {
    client = Client();
    client.setEndpoint(endpoint);
    client.setProject(projectId);
    databases = Databases(client);
  }

  Future<List<Document>> getTasks() async {
    try {
      final result = await databases.listDocuments(
          databaseId: databaseId, collectionId: collectionId);
      return result.documents;
    } catch (e) {
      print('Error loading notes:$e');
      rethrow;
    }
  }

  Future<Document> addTask(String title, String description,String Date,String Time) async {
    try {
      final documentId = ID.unique();

      final result = await databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        data: {
          'title': title,
          'description': description,
          'Date':Date,
          'Time':Time,
        },
        documentId: documentId,
      );
      return result;
    } catch (e) {
      print('Error creating note:$e');
      rethrow;
    }
  }

  Future<void> deleteTask(String documentId) async {
    try {
      await databases.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
    } catch (e) {
      print('Error deleting note:$e');
      rethrow;
    }
  }
}
