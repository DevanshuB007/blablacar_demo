import 'package:blablacar/page/signup_page.dart';
import 'package:blablacar/screen/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Color(0xFF0fa6e3),
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'How do you want to Login?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF024550),
              ),
            ),
            const SizedBox(height: 40),
            // Email Sign Up Button
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.email_outlined,
                            color: Colors.grey),
                        title: const Text(
                          'Continue with email',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Loginpage()));
                          // Email sign up action
                        },
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
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
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // SizedBox(height: 20),

            // Facebook Sign Up Button

            const SizedBox(height: 30),
            const Text(
              'Not a member?',
              style: TextStyle(fontSize: 25, color: Color(0xFF024550)),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(
                      0xFF0fa6e3,
                    )),
              ),
            ),
            const SizedBox(height: 20),
            // Terms and Privacy
          ],
        ),
      ),
    );
  }
}
