import 'package:appwrite/models.dart' as models;
import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

class UserProvider extends ChangeNotifier {
  final Client _client = Client()
      .setEndpoint(AuthConfig.endpoint)
      .setProject(AuthConfig.projectId)
      .setSelfSigned(status: true);

  late final Account _account;
  late final Databases _database;
  String? _userId;
  Map<String, dynamic>? _userData;
  bool _isLoading = false;

  UserProvider() {
    _account = Account(_client);
    _database = Databases(_client);
  }

  String? get userId => _userId;
  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;

  String _email = '';
  String _firstname = '';
  String _lastname = '';
  String _dob = '';
  String _password = '';
  String _phone = '';

  String get email => _email;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get dob => _dob;
  String get password => _password;
  String get phone => _phone;

  //  Set User Data
  void setUserData(String key, String value) {
    switch (key) {
      case "email":
        _email = value;
        break;
      case "firstname":
        _firstname = value;
        break;
      case "lastname":
        _lastname = value;
        break;
      case "dob":
        _dob = value;
        break;
      case "password":
        _password = value;
        break;
      case "phone":
        _phone = value;
        break;
    }
    print("🔹 User Data Set: $key : $value");
    notifyListeners();
  }

  //  Register User
  Future<void> registerUser() async {
    try {
      final user = await _account.create(
        userId: ID.unique(),
        email: _email,
        password: _password,
      );

      _userId = user.$id;
      print(" User registered: $_userId");

      //  Log in user before saving data
      await _account.createEmailPasswordSession(
          email: _email, password: _password);
      print(" User logged in successfully");

      //  Save user data in database
      await saveUserDataToAppwrite();
    } catch (e) {
      print("Error registering user: $e");
    }
  }

  //  Save User Data in Appwrite Database
  Future<void> saveUserDataToAppwrite() async {
    if (_userId == null) {
      print(" User not authenticated! _userId is null");
      return;
    }

    try {
      print("🔍 Saving data for user ID: $_userId");

      final response = await _database.createDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.collectionId,
        documentId: _userId!,
        data: {
          "email": _email,
          "firstname": _firstname,
          "lastname": _lastname,
          "dob": _dob,
          "password": _password,
          "phone": _phone,
        },
        permissions: [
          Permission.read(Role.any()), //  Allow reading for debugging
          Permission.write(Role.user(_userId!)),
          Permission.update(Role.user(_userId!)),
          Permission.delete(Role.user(_userId!)),
        ],
      );

      print(" User data stored successfully: ${response.data}");
    } catch (e) {
      print(" Error storing user data: $e");
    }
  }

  //  Fetch User Data
  //  Fetch User Data
  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();

    try {
      //  Check if user has an active session
      final sessions = await _account.listSessions();
      if (sessions.sessions.isEmpty) {
        print(" No active session found. Please log in first.");
        _isLoading = false;
        notifyListeners();
        return;
      }

      //  Get authenticated user
      models.User user = await _account.get();
      _userId = user.$id;

      if (_userId == null || _userId!.isEmpty) {
        print(' Error: User ID is null or empty.');
        _isLoading = false;
        notifyListeners();
        return;
      }

      print("🔍 Fetching data for user ID: $_userId");

      //  Search for user data using the `userId` field
      final response = await _database.listDocuments(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.collectionId,
        queries: [Query.equal('userId', _userId!)], //  Correct query
      );

      if (response.documents.isNotEmpty) {
        _userData = response.documents.first.data;
        print(" User Data: $_userData");
      } else {
        print(" No user document found. Please ensure data is saved.");
        // 🔹 Suggest saving user data
        await saveUserDataToAppwrite();
      }
    } catch (e) {
      print(" Error fetching user data: $e");

      // Debugging: List all documents in the collection
      try {
        final documents = await _database.listDocuments(
          databaseId: AuthConfig.databaseId,
          collectionId: AuthConfig.collectionId,
        );
        print(
            " Available Documents: ${documents.documents.map((doc) => doc.data).toList()}");
      } catch (err) {
        print(" Error listing documents: $err");
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
