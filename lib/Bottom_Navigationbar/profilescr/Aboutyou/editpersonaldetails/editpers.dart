import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/addbio.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/editpersonaldetails/edit_screen/editdobscreen.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/editpersonaldetails/edit_screen/editlastname.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/editpersonaldetails/edit_screen/editfirstname.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/editpersonaldetails/edit_screen/editmailscreen.dart';
import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class Editpers extends StatefulWidget {
  const Editpers({super.key});

  @override
  State<Editpers> createState() => _EditpersState();
}

class _EditpersState extends State<Editpers> {
  final Client _client = Client()
      .setEndpoint(AuthConfig.endpoint) //  Your Appwrite endpoint
      .setProject(AuthConfig.projectId); //  Your Project ID

  late Databases _databases;
  late Account _account;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? userId;
  String? _bio;
  bool _isSaving = false; //  Loading state for saving bio

  @override
  void initState() {
    super.initState();
    _databases = Databases(_client);
    _account = Account(_client);
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      models.User user = await _account.get();
      userId = user.$id;

      models.Document response = await _databases.getDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.collectionId,
        documentId: userId!,
      );

      setState(() {
        userData = response.data;
        _bio = response.data['bio'];
        isLoading = false;
      });
    } catch (e) {
      print(' Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateUserBio(String newBio) async {
    setState(() {
      _isSaving = true;
    });

    try {
      await _databases.updateDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.collectionId,
        documentId: userId!,
        data: {"bio": newBio},
      );

      setState(() {
        _bio = newBio;
      });
    } catch (e) {
      print(" Error updating bio: $e");
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _updateUserField(String field, String value) async {
    setState(() => _isSaving = true);

    try {
      await _databases.updateDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.collectionId,
        documentId: userId!,
        data: {field: value},
      );

      setState(() {
        userData?[field] = value;
      });
    } catch (e) {
      print("Error updating $field: $e");
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.blue),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) //  Show loading
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personal Details',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),

                  //  First Name
                  ListTile(
                    onTap: () async {
                      final updatedFirstName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditFirstName(
                            currentFirstName: userData?['firstname'],
                          ),
                        ),
                      );

                      if (updatedFirstName != null &&
                          updatedFirstName is String) {
                        _updateUserField('firstname', updatedFirstName);
                      }
                    },
                    title: const Text(
                      'First Name',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    subtitle: Text(
                      userData?['firstname'] ?? 'N/A',
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),

                  //  Last Name
                  ListTile(
                    onTap: () async {
                      final updatedLastName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Editlastnamescreen(
                            currentFirstName: userData?['lastname'],
                          ),
                        ),
                      );

                      if (updatedLastName != null &&
                          updatedLastName is String) {
                        _updateUserField('lastname', updatedLastName);
                      }
                    },
                    title: const Text(
                      'Last Name',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    subtitle: Text(
                      userData?['lastname'] ?? 'N/A',
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),

                  //  Date of Birth
                  ListTile(
                    onTap: () async {
                      final updatedDOB = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Editdobscreen(
                            currentFirstName: userData?['dob'],
                          ),
                        ),
                      );

                      if (updatedDOB != null && updatedDOB is String) {
                        _updateUserField('dob', updatedDOB);
                      }
                    },
                    title: const Text(
                      'Date of Birth',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    subtitle: Text(
                      userData?['dob'] ?? 'N/A',
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                  // ListTile(
                  //   title: const Text(
                  //     'Date of Birth',
                  //     style: TextStyle(
                  //         color: Colors.grey,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 16),
                  //   ),
                  //   subtitle: Text(
                  //     userData?['dob'] ?? 'N/A',
                  //     style: TextStyle(
                  //         color: Colors.blue.shade600,
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 16),
                  //   ),
                  // ),

                  //  Email Address
                  ListTile(
                    onTap: () async {
                      final updatedEmail = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Editemailscreen(
                            currentFirstName: userData?['email'],
                          ),
                        ),
                      );

                      if (updatedEmail != null && updatedEmail is String) {
                        _updateUserField('email', updatedEmail);
                      }
                    },
                    title: const Text(
                      'Email Address',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    subtitle: Text(
                      userData?['email'] ?? 'N/A',
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                  // ListTile(
                  //   title: const Text(
                  //     'Email Address',
                  //     style: TextStyle(
                  //         color: Colors.grey,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 16),
                  //   ),
                  //   subtitle: Text(
                  //     userData?['email'] ?? 'N/A',
                  //     style: TextStyle(
                  //         color: Colors.blue.shade600,
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 16),
                  //   ),
                  // ),

                  //  Phone Number
                  ListTile(
                    leading: const Icon(Icons.add_circle_outline,
                        color: Colors.blue),
                    title: const Text(
                      'Add Phone Number',
                      style: TextStyle(color: Colors.blue),
                    ),
                    subtitle: Text(
                      userData?['phone'] ?? 'N/A',
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),

                  const Divider(),

                  //  Mini Bio
                  ListTile(
                    onTap: () async {
                      final updatedBio = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Addbio(currentBio: _bio)),
                      );

                      if (updatedBio != null && updatedBio is String) {
                        _updateUserBio(updatedBio);
                      }
                    },
                    leading: _bio == null || _bio!.isEmpty
                        ? const Icon(Icons.add_circle_outline,
                            color: Colors.blue)
                        : null,
                    title: Text(
                      _bio == null || _bio!.isEmpty ? 'Add a bio' : 'Bio',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      _bio == null || _bio!.isEmpty ? 'Add a bio' : _bio!,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
