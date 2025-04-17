import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:blablacar/appwrite/app/data/config/auth_config.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final Client _client = Client()
      .setEndpoint(AuthConfig.endpoint) //  Use endpoint from config
      .setProject(AuthConfig.projectId)
      .setSelfSigned(status: true); //  Self-signed SSL if needed

  late Account _account;
  late Databases _databases;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? _userId; //  Store authenticated user ID

  @override
  void initState() {
    super.initState();
    _account = Account(_client);
    _databases = Databases(_client);
    _fetchUserIdAndData(); //  Fetch user ID first, then user data
  }

  //  Step 1: Fetch Authenticated User ID
  Future<void> _fetchUserIdAndData() async {
    try {
      models.User user = await _account.get();
      _userId = user.$id; //  Get logged-in user's ID
      print(" Authenticated User ID: $_userId");

      //  Step 2: Fetch user data from Appwrite database
      await _fetchUserData();
    } catch (e) {
      print(' Error fetching user ID: $e');
      setState(() => isLoading = false);
    }
  }

  //  Step 2: Fetch User Data from Appwrite Database
  Future<void> _fetchUserData() async {
    if (_userId == null) {
      print(' Error: User ID is null.');
      setState(() => isLoading = false);
      return;
    }

    try {
      models.Document response = await _databases.getDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.collectionId,
        documentId: _userId!, //  Use dynamic user ID
      );

      setState(() {
        userData =
            response.data.map((key, value) => MapEntry(key, value ?? ''));
        isLoading = false;
      });

      print(" User Data Fetched: $userData");
    } catch (e) {
      print(' Error fetching user data: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text(" No data found."))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: userData?['profileImage'] != ''
                                ? NetworkImage(userData!['profileImage'])
                                : null,
                            child: userData?['profileImage'] == ''
                                ? const Icon(Icons.person,
                                    color: Colors.white, size: 50)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData?['firstname'] ?? 'N/A',
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Text('${userData?['age'] ?? 'N/A'} y/o'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text('Experience level: Newcomer'),
                    ),
                    const SizedBox(height: 20),
                    const Divider(thickness: 6),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'About Me',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.chat, color: Colors.grey),
                      title: Text(
                        userData?['bio'] ?? "No bio available",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      onTap: () {},
                    ),
                    const Divider(thickness: 6),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'My Rides',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: const Text("No rides published",
                          style: TextStyle(color: Colors.grey)),
                      onTap: () {},
                    ),
                  ],
                ),
    );
  }
}
