import 'package:appwrite/appwrite.dart';
import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
import 'package:blablacar/screen/homepage.dart';
import 'package:flutter/material.dart';

class Otpscr extends StatefulWidget {
  final String phoneNumber; //  Receive phone number from Phoneauth

  const Otpscr({super.key, required this.phoneNumber});

  @override
  State<Otpscr> createState() => _OtpscrState();
}

class _OtpscrState extends State<Otpscr> {
  final Client _client = Client()
      .setEndpoint(AuthConfig.endpoint)
      .setProject(AuthConfig.projectId)
      .setSelfSigned(status: true);

  late final Account _account;
  late final Databases _database;
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false; //  Show loading indicator

  @override
  void initState() {
    super.initState();
    _account = Account(_client);
    _database = Databases(_client);
  }

  //  Verify OTP Function
  Future<void> verifyOtp() async {
    String otp = _otpController.text.trim();
    if (otp.isEmpty) {
      print(" OTP is empty!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      //  Step 1: Verify OTP
      final session = await _account.updatePhoneSession(
        userId: ID.unique(),
        secret: otp,
      );

      print(" OTP Verified! User ID: ${session.userId}");

      //  Step 2: Store Phone Number in Database
      await _database.createDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.collectionId,
        documentId: session.userId,
        data: {
          "phone": widget.phoneNumber,
        },
        permissions: [
          Permission.read(Role.user(session.userId)),
          Permission.update(Role.user(session.userId)),
          Permission.delete(Role.user(session.userId)),
        ],
      );

      print(" Phone number stored successfully!");

      //  Step 3: Navigate to Home
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Myhomepage()));
    } catch (e) {
      print(" Error verifying OTP: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  //  Resend OTP Function
  Future<void> resendOtp() async {
    try {
      await _account.createPhoneVerification();
      print(" OTP Resent to ${widget.phoneNumber}");
    } catch (e) {
      print(" Error resending OTP: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Enter the code we've just sent you by SMS or WhatsApp",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF024550)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: "4-digit code",
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text("Resend code", style: TextStyle(fontSize: 15)),
              trailing: const Icon(Icons.refresh, color: Colors.blue),
              onTap: resendOtp, //  Call resendOtp function
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading ? null : verifyOtp, //  Disable when loading
        backgroundColor: Colors.blue,
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.white) //  Show loading
            : const Icon(Icons.arrow_forward, size: 30),
      ),
    );
  }
}
