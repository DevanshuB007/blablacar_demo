import 'dart:async';
import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
import 'package:blablacar/screen/homepage.dart';
import 'package:blablacar/screen/registration.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final Client _client = Client()
      .setEndpoint(AuthConfig.endpoint) //  Your Appwrite endpoint
      .setProject(AuthConfig.projectId); //  Your Appwrite project ID

  late final Account _account;

  @override
  void initState() {
    super.initState();
    _initializeAccount(); //  Initialize account first
  }

  //  Initialize the Appwrite Account before calling session check
  void _initializeAccount() {
    _account = Account(_client);
    _checkUserSession(); //  Now it's safe to check user session
  }

  //  Check if user has an active session
  Future<void> _checkUserSession() async {
    try {
      await _account.getSession(sessionId: 'current'); //  Get active session
      // 🔹 User is logged in, navigate to Home Page
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Myhomepage()),
        );
      }
    } catch (e) {
      //  No active session, show splash & navigate to Registration
      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Registration()),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Image.asset(
          'assets/images/icon.PNG',
          height: 500,
        ),
      ),
    );
  }
}
