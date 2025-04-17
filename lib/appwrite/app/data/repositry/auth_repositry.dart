import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteProvider {
  final Client _client;
  late final Account _account;

  AppwriteProvider()
      : _client = Client()
          ..setEndpoint("https://cloud.appwrite.io/v1") // Your Appwrite URL
          ..setProject("67b32bd4000cb9b3af45") {
    _account = Account(_client);
  }

  Future<User> signup(Map<String, dynamic> map) async {
    try {
      return await _account.create(
        userId: ID.unique(),
        email: map['email'],
        password: map['password'],
      );
    } catch (e) {
      throw Exception("Signup failed: $e");
    }
  }
}
