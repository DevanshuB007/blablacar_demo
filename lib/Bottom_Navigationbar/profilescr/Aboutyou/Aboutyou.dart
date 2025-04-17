import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/add_edit_car/editcar.dart'; // Ensure this file contains the EditCar class definition
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/add_edit_car/vehicalpro.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/addprofile.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/addvehicle.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/confemail.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/addbio.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/edit%20travel%20pref/edittravelpref.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/editpersonaldetails/editpers.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/editprofile.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/verifygov.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/create%20ride/id.dart';
import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
import 'package:blablacar/appwrite/app/data/provider/radio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Aboutyou extends StatefulWidget {
  const Aboutyou({super.key});

  @override
  State<Aboutyou> createState() => _AboutyouState();
}

class _AboutyouState extends State<Aboutyou> {
  final Client _client = Client()
      .setEndpoint(AuthConfig.endpoint)
      .setProject(AuthConfig.projectId);

  late Databases _databases;
  late Account _account;
  bool isLoading = true;
  String? userId;
  List<Map<String, dynamic>> vehicles = [];

  String? _selectedChattiness; // Default value

  final Map<String, IconData> chattinessIcons = {
    "I love to chat": Icons.chat_bubble_outline,
    "I'm chatty when I feel comfor-table": Icons.message_outlined,
    "I'm the quiet type": Icons.chat_bubble,
  };
  String _selectedMusic = "I'll am depending on the mood"; // Default value

  final Map<String, IconData> musicIcons = {
    "I'll am depending on the mood": Icons.music_note,
    "I love to jam": Icons.music_off,
    "I prefer silence": Icons.music_off,
  };

  String _selectedSmoking = "No smoking, please"; // Default value

  final Map<String, IconData> smokingIcons = {
    "No smoking, please": Icons.smoking_rooms,
    "Cigarette breaks outside the car are ok": Icons.smoking_rooms,
    "I smoke inside the car": Icons.smoking_rooms,
  };

  String _selectedPetOption =
      "I'll travel with pets depending on the animal"; // Default value

  final Map<String, IconData> petIcons = {
    "I'll travel with pets depending on the animal": Icons.pets,
    "I prefer no pets": Icons.pets,
    "Pets are welcome": Icons.pets,
  };

  @override
  void initState() {
    super.initState();
    _databases = Databases(_client);
    _account = Account(_client); //  Initialize Account
    _fetchUserData();
  }

  // Fetch vehicles from Appwrite database
  Future<void> _fetchVehicles() async {
    print("🔄 Fetching all vehicles...");

    try {
      final response = await _databases.listDocuments(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.vehicalcollectionId, // Vehicles collection
      );

      print("📄 All Vehicles Response: ${response.documents}");

      List<Map<String, dynamic>> fetchedVehicles =
          response.documents.map((doc) {
        return {
          'id': doc.$id,
          'brand_name': doc.data['brand_name'],
          'model_name': doc.data['model_name'],
          'color_name': doc.data['color_name'],
        };
      }).toList();

      setState(() {
        vehicles = fetchedVehicles;
        isLoading = false;
      });

      print(" All Vehicles fetched: $vehicles");
    } catch (e) {
      print(" Error fetching vehicles: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  //  Fetch User ID and Profile Data
  Future<void> _fetchUserData() async {
    try {
      //  Get logged-in user
      final models.User user = await _account.get();
      userId = user.$id;

      //  Fetch user profile data from Appwrite Database
      models.Document response = await _databases.getDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.collectionId,
        documentId: userId!,
      );

      setState(() {
        userData = response.data;
        isLoading = false;
      });

      // print(" User Data Fetched: $userData");

      //  Fetch vehicles after fetching user data
      await _fetchVehicles();
    } catch (e) {
      print(' Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Map<String, dynamic>? userData;

  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<RadioProvider>(context);
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //  Profile Image from Appwrite
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ClipOval(
                      child: userData?['profileImage'] != null &&
                              userData?['profileImage'].isNotEmpty
                          ? Image.network(
                              userData!['profileImage'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person,
                                      size: 80, color: Colors.grey),
                            )
                          : const Icon(Icons.person,
                              size: 90, color: Colors.grey),
                    ),

              const SizedBox(width: 20),

              //  User Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData?['firstname'] ??
                          'User Name', // 🔹 Fetching First Name
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const Text('Newcomer')
                  ],
                ),
              ),

              // 🔹 Edit Profile Button
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Editprofile()));
                },
                icon: const Icon(Icons.arrow_forward_ios_outlined, size: 20),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline, color: Colors.blue),
            title: const Text(
              'Add Profile picture',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Addprofile()));
            },
          ),
          ListTile(
            title: const Text(
              'Edit personal details',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Editpers()));
            },
          ),
          const Divider(),
          const Text(
            'Verify your profile',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline, color: Colors.blue),
            title: const Text(
              'Verify your Govt. ID',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Verifygov()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline, color: Colors.blue),
            title: Text('Confirm email ${userData?['email'] ?? 'N/A'}',
                style: TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Confemail()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline, color: Colors.blue),
            title: Text('Add Phone number',
                style: const TextStyle(color: Colors.blue)),
            onTap: () {},
          ),
          const Divider(
            height: 40,
          ),
          const Text(
            'About You ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: userData?['bio'] == null || userData?['bio'].isEmpty
                ? const Icon(Icons.add_circle_outline, color: Colors.blue)
                : null, // Hide icon if bio is present
            title: Text(
              userData?['bio']?.isNotEmpty == true
                  ? userData!['bio']
                  : 'Add a mini bio',
              style: TextStyle(
                  color: userData?['bio']?.isNotEmpty == true
                      ? Colors.black
                      : Colors.blue),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Addbio()),
              );
            },
          ),
          ListTile(
            leading: Icon(radioProvider.selectedChattinessIcon ?? Icons.chat,
                color: Colors.grey), // Change dynamically-
            title: Text(
              radioProvider.selectedOption ?? 'I love to chat',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: Icon(radioProvider.selectedMusicIcon ?? Icons.music_note,
                color: Colors.grey), // Change dynamically
            title: Text(
              radioProvider.selectedMusic ?? "I'll am depending on the mood",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: Icon(
                radioProvider.selectedSmokingIcon ?? Icons.smoking_rooms,
                color: Colors.grey), // Change dynamically

            title: Text(
              radioProvider.selectedSmoking ?? "No smoking, please",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: Icon(radioProvider.selectedPetIcon ?? Icons.pets,
                color: Colors.grey), // Change dynamically
            title: Text(
              radioProvider.selectedPetOption ?? "Pets welcome.woof!",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.add_circle_outline,
              color: Colors.blue,
            ),
            title: const Text(
              'Edit travel Preferences',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Edittravelpref()));
            },
          ),
          const Divider(
            height: 40,
          ),
          const Text(
            'Vehicles',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator()) // Loading state
              : vehicles.isEmpty
                  ? const Center(
                      child: Text(
                        "No vehicles found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  : SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: vehicles.length,
                        itemBuilder: (context, index) {
                          final vehicle = vehicles[index];

                          return GestureDetector(
                            onTap: () {
                              print(vehicle['id']);
                              print("this is the id of the vehicle.......");
                            },
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    vehicle['brand_name'] ?? 'Unknown Brand',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    vehicle['model_name'] ?? 'Unknown Model',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                "${vehicle['color_name'] ?? 'Unknown'}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Editcar(
                                      carId: vehicle['id'],
                                      // brand: vehicle['brand_name'],
                                      // model: vehicle['model_name'],
                                      // color: vehicle['color_name'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
          ListTile(
            leading: const Icon(
              Icons.add_circle_outline,
              color: Colors.blue,
            ),
            title: const Text(
              'Add vehicle',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Addvehicle()));
            },
          )
        ],
      ),
    );
  }
}
