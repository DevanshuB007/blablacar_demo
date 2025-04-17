import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:blablacar/Bottom_Navigationbar/inbox_scr.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/profile_scr.dart';
import 'package:blablacar/Bottom_Navigationbar/publish_scr.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/search_scr.dart';
import 'package:blablacar/Bottom_Navigationbar/yourride_scr.dart';
import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
import 'package:flutter/material.dart';

class BottomScr extends StatefulWidget {
  const BottomScr({super.key});

  @override
  State<BottomScr> createState() => _BottomScrState();
}

class _BottomScrState extends State<BottomScr> {
  int currentIndexvalue = 0;
  String? profileImageUrl; //  Store profile image URL
  bool isLoading = true; //  Track loading state

  final Client _client = Client()
      .setEndpoint(AuthConfig.endpoint) //  Your Appwrite endpoint
      .setProject(AuthConfig.projectId); //  Your Appwrite project ID
  late final Databases _databases;
  late final Account _account;

  List screenlist = [
    const SearchScr(),
    const PublishScr(),
    const YourrideScr(),
    const InboxScr(),
    const ProfileScr(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAppwrite();
  }

  //  Initialize Appwrite services
  void _initializeAppwrite() {
    _databases = Databases(_client);
    _account = Account(_client);
    _fetchProfileImage();
  }

  //  Fetch the user's profile image from Appwrite database
  Future<void> _fetchProfileImage() async {
    try {
      final User user = await _account.get(); // 🔹 Get current user
      final String userId = user.$id;

      final Document userData = await _databases.getDocument(
        databaseId: AuthConfig.databaseId, // 🔹 Your Appwrite Database ID
        collectionId: AuthConfig.collectionId, // 🔹 Users Collection ID
        documentId: userId, // 🔹 Fetch logged-in user's data
      );

      if (mounted) {
        //  Ensure widget is still in the tree
        setState(() {
          profileImageUrl =
              userData.data['profileImage']; //  Fetch profile image URL
          isLoading = false; //  Stop loading
        });
      }
    } catch (e) {
      debugPrint(' Error fetching user data: $e');
      if (mounted) {
        setState(() {
          isLoading = false; //  Stop loading even on error
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndexvalue,
        onTap: (index) {
          setState(() {
            currentIndexvalue = index;
          });
        },
        selectedItemColor: const Color(0xFF0fa6e3),
        unselectedItemColor: const Color(0xFFa0a0a0),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_outlined),
            label: 'Publish',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Your rides',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2, //  Show loading indicator
                    ),
                  )
                : profileImageUrl != null
                    ? CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(profileImageUrl!),
                      )
                    : const Icon(
                        Icons.person), //  Show default icon if no image
            label: 'Profile',
          ),
        ],
      ),
      body: screenlist[currentIndexvalue],
    );
  }
}
