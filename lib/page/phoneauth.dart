import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
import 'package:blablacar/page/otpscr.dart';
import 'package:blablacar/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Phoneauth extends StatefulWidget {
  const Phoneauth({super.key});

  @override
  State<Phoneauth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<Phoneauth> {
  final Client _client = Client()
      .setEndpoint(AuthConfig.endpoint)
      .setProject(AuthConfig.projectId)
      .setSelfSigned(status: true);

  late final Account _account;
  late final Databases _database; 
  String _phoneNumber = ''; // Store phone number

  @override
  void initState() {
    super.initState();
    _account = Account(_client);
    _database = Databases(_client);
  }

  Future<void> sendOtp() async {
    if (_phoneNumber.isEmpty) {
      print(" Phone number is empty!");
      return;
    }

    try {
      //  Send OTP (for example, using a fixed OTP)
      String otp = "123456"; // Replace with actual OTP generation logic
      await _account.updatePhoneVerification(userId: ID.unique(), secret: otp);

      print(" OTP sent to $_phoneNumber");

      //  Save phone number to database
      await savePhoneNumberToDatabase();

      //  Navigate to OTP screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Otpscr(phoneNumber: _phoneNumber),
        ),
      );
    } catch (e) {
      print(" Error sending OTP: $e");
    }
  }

  Future<void> savePhoneNumberToDatabase() async {
    try {
      await _database.createDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: "users", // Ensure this collection exists
        documentId: ID.unique(),
        data: {
          "phoneNumber": _phoneNumber,
        },
      );
      print(" Phone number saved to database");
    } catch (e) {
      print(" Error saving phone number: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.blue, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Verify your mobile number ',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF024550)),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(5),
              child: IntlPhoneField(
                initialCountryCode: 'IN',
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFededed),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFededed)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFededed)),
                  ),
                  hintText: "Enter phone number",
                  hintStyle:
                      TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                ),
                onChanged: (value) {
                  _phoneNumber = value.completeNumber; // Store the phone number
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text("I'll do it later",
                  style: TextStyle(fontSize: 15)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Myhomepage()));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendOtp, //  Call sendOtp when button is clicked
        backgroundColor: Colors.blue,
        child: const Icon(Icons.arrow_forward, size: 30),
      ),
    );
  }
}
