import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
import 'package:blablacar/page/signup_page.dart';
import 'package:blablacar/screen/forgotpass.dart';
import 'package:blablacar/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false; // 👁️ Password Visibility Toggle

  final Client _client = Client()
      .setEndpoint(AuthConfig.endpoint) // Appwrite endpoint
      .setProject(AuthConfig.projectId); // Appwrite Project ID

  late final Account _account;

  @override
  void initState() {
    super.initState();
    _account = Account(_client);
    _checkUserSession(); //  Check if user is already logged in
  }

  //  Auto Login: Check if User is Already Logged In
  Future<void> _checkUserSession() async {
    try {
      final session = await _account.get();
      if (session != null) {
        //  User is logged in, navigate to Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Myhomepage()),
        );
      }
    } catch (e) {
      //  No active session, stay on login screen
      print("No active session: $e");
    }
  }

  //  Handle Login
  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('⚠️ Please enter both email and password.');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      await _account.createEmailPasswordSession(
          email: email, password: password);
      _showSnackBar(' Login successful!', success: true);

      //  Navigate to Home Page after login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Myhomepage()),
      );
    } catch (e) {
      _showSnackBar('Login failed: ${e.toString()}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  // 📢 Show SnackBar Messages
  void _showSnackBar(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "What's your email and password?",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 📧 Email Input
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),

              // 🔒 Password Input with Visibility Toggle
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),

              //  Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Forgotpass()));
                    // Implement Forgot Password Logic Here
                  },
                  child: Text("Forgot password?",
                      style: TextStyle(color: Colors.cyan.shade800)),
                ),
              ),

              const SizedBox(height: 30),

              // 🔵 Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Log in", style: TextStyle(fontSize: 18)),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Sign Up Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupPage()),
                        );
                      },
                      child: const Text("Sign Up",
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
