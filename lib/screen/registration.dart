import 'package:blablacar/screen/login.dart';
import 'package:blablacar/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/logscr.JPG',
                    fit: BoxFit.cover,
                    height: size.height * 0.70,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: size.height * 0.05,
                    left: size.width * 0.4,
                    child: Image.asset(
                      'assets/images/icon.PNG',
                      width: size.width * 0.2,
                      height: size.width * 0.2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'Your pick of at rides at \n low prices ',
                style: GoogleFonts.roboto(
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF004652),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: size.width * 0.90,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Signup(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00b2fc),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF0eabe0),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.015,
                  ),
                  textStyle: TextStyle(
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Log in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
