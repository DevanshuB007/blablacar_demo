import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:blablacar/appwrite/app/data/config/auth_config.dart';

class AppwriteProvider {
  Client client = Client();

  late final Databases databases;
  late final Account account;

  AppwriteProvider() {
    client
        .setEndpoint(AuthConfig.endpoint) // Your Appwrite endpoint
        .setProject(AuthConfig.projectId) // Your Appwrite project ID
        .setSelfSigned(status: true);

    account = Account(client);
    databases = Databases(client);
  }

  Future<void> signUpUser(String email, String password, String name) async {
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      print(" Signup Successful");
    } catch (e) {
      print(" Signup Error: $e");
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      print(" Login Successful");
    } catch (e) {
      print(" Login Error: $e");
    }
  }

  Future<dynamic> logout(String sessionId) async {
    try {
      await account.deleteSession(
        sessionId: sessionId,
      );
      print(" log out Successful");
    } catch (e) {
      print(" logout Error: $e");
    }
  }

  Future<void> checkUserSession() async {
    try {
      final session = await account.get();
      print(" User is logged in: ${session.email}");
    } catch (e) {
      print(" No active session.");
    }
  }
}
