import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:appwrite/appwrite.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({super.key});

  @override
  State<Forgotpass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<Forgotpass> {
  final TextEditingController emailController = TextEditingController();

  bool showSendButton = false;
  bool isDone = false;

  // Initialize Appwrite Account
  late Client client;
  late Account account;

  @override
  void initState() {
    super.initState();
    client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
        .setProject(AuthConfig.projectId); // Your Project ID

    account = Account(client);
  }

  Future<void> sendResetLink() async {
    try {
      await account.createRecovery(
        email: emailController.text.trim(),
        url: 'https://your-app.com/reset-password', // Your Web URL
      );

      setState(() {
        isDone = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reset Link Sent! Check Email')),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0fa6e3)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "What's your email? Check your inbox for a link to create a new password.",
              style: GoogleFonts.roboto(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              onChanged: (value) {
                setState(() {
                  showSendButton = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),
            if (showSendButton)
              Center(
                child: ElevatedButton(
                  onPressed: isDone ? null : sendResetLink,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0fa6e3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                  ),
                  child: const Text(
                    "Send",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
