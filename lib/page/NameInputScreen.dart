import 'package:blablacar/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dobscreen.dart';

class NameInputScreen extends StatefulWidget {
  final String email; // Accept email as a parameter

  const NameInputScreen({super.key, required this.email});

  @override
  _NameInputScreenState createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void saveNameAndProceed() {
    final firstname = _firstNameController.text.trim();
    final lastname = _lastNameController.text.trim();

    if (firstname.isEmpty || lastname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both first and last name.")),
      );
      return;
    }

    // Save name in provider
    Provider.of<UserProvider>(context, listen: false)
        .setUserData("firstname", firstname);
    Provider.of<UserProvider>(context, listen: false)
        .setUserData("lastname", lastname);

    // Navigate to DOB screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Dobscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 10),
            Text(
              "What's your name?",
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              //  TextStyle(
              //   fontSize: 28,
              //   fontWeight: FontWeight.bold,
              //   color: Colors.black,
              // ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: "First name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: "Last name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveNameAndProceed,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
