import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:shared_preferences/shared_preferences.dart';

class AuthConfig {
  static String endpoint = "https://cloud.appwrite.io/v1";
  static String projectId = "67b32bd4000cb9b3af45";
  static String databaseId = "67e144bf0004107a1d5c";
  static String collectionId = "67e144da0011ae3aba96";
  static String bucketId = "67e146060014fbe1ba92";
  static String vehicalcollectionId = "67ee29ff001fcfe529fa";


  static final Client client =
      Client().setEndpoint(endpoint).setProject(projectId);
  static final Account account = Account(client);
  static final Databases databases = Databases(client);

  static var documentId;

  //  Get Logged-In User ID
  static Future<String?> getCurrentUserId() async {
    try {
      models.User user = await account.get();
      return user.$id;
    } catch (e) {
      print(" Error fetching user ID: $e");
      return null;
    }
  }

  //  Get or Create Document ID
  static Future<String?> getOrCreateUserDocument() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedDocId = prefs.getString("documentId");

    if (storedDocId != null) {
      return storedDocId; //  Use stored document ID
    }

    String? userId = await getCurrentUserId();
    if (userId == null) return null;

    try {
      //  Check if the user already has a document
      final documents = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [Query.equal("userId", userId)],
      );

      if (documents.documents.isNotEmpty) {
        String existingDocId = documents.documents.first.$id;
        await prefs.setString("documentId", existingDocId); //  Cache it
        return existingDocId;
      }
    } catch (e) {
      print(" Error fetching user document: $e");
    }

    //  If no document exists, create one with a unique ID
    try {
      final newDocument = await databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(), //  Automatically generate document ID
        data: {
          "userId": userId, // Store userId for reference
          "firstname": "firstname",
          "lastname": "lastname",
          "email": "",
          "profileImage": "",
          "phone": "",
          "bio": "",
        },
      );

      await prefs.setString("documentId", newDocument.$id); //  Cache it
      return newDocument.$id;
    } catch (e) {
      print(" Error creating user document: $e");
      return null;
    }
  }
}
