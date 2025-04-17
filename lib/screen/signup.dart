import 'package:blablacar/page/signup_page.dart';
import 'package:blablacar/screen/homepage.dart';
import 'package:blablacar/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Color(0xFF0fa6e3),
            size: 30,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Myhomepage()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'How do you want to \nsign up?',
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF024550),
                ),
                // TextStyle(
                //   fontSize: 28,
                //   fontWeight: FontWeight.w600,
                //   color: Color(0xFF024550),
                // ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.email_outlined,
                            color: Colors.grey),
                        title: const Text(
                          'Sign up with your email',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey),
                        onTap: () {
                          // Email sign up action
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()));
                        },
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 1),
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.facebook, color: Colors.blue),
                        title: const Text(
                          'Continue with Facebook',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey),
                        onTap: () {
                          // Facebook sign up action
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Already a member?',
                style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF024550),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Terms and Privacy
              const Text(
                'By signing up, you accept our Terms and Conditions and Privacy Policy.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                'This information is collected by COMUTO SA for the purposes of creating your account, managing your booking, using and improving our services and ensuring the security of our platform.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                'You have rights on your personal data and can exercise them by contacting BlaBlaCar through our Contact form. You can learn more about your rights and how we handle your personal data in our Privacy Policy.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
