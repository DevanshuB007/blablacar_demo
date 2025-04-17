import 'dart:math';
import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
import 'package:blablacar/page/NameInputScreen.dart';
import 'package:blablacar/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:appwrite/appwrite.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  bool isChecked = false;

  final Client client = Client()
      .setEndpoint(AuthConfig.endpoint)
      .setProject(AuthConfig.projectId)
      .setSelfSigned(status: true);

  late final Account account;

  @override
  void initState() {
    super.initState();
    account = Account(client);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> signUpUser() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an email.')),
      );
      return;
    }

    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept Terms & Conditions')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      Provider.of<UserProvider>(context, listen: false)
          .setUserData("email", email);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NameInputScreen(
                  email: '',
                )),
      );
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0fa6e3),
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: size.height * 0.03),
              Text(
                "What's your email?",
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF024550),
                ),
                // TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: size.height * 0.03),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: size.height * 0.02),

              // Checkbox Row
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.blue,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          "i don't want to receive special offers and personalized recommendations via email",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.robotoSlab(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF024550),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "By entering your email,you agree to receive promotional emails from BlaBlaCar.Opt out now by checking the box above or at any time in your profile settings.",
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  // fontWeight: FontWeight.w500,
                  color: Color(0xFF024550),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _emailController.text.isNotEmpty
          ? FloatingActionButton(
              onPressed: signUpUser,
              backgroundColor: Colors.blue,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Icon(Icons.arrow_forward),
            )
          : null,
    );
  }
}
