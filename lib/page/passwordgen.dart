import 'package:blablacar/page/phoneauth.dart';
import 'package:blablacar/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Passwordgen extends StatefulWidget {
  const Passwordgen({super.key});

  @override
  State<Passwordgen> createState() => _PasswordgenState();
}

class _PasswordgenState extends State<Passwordgen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String? _errorMessage;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _validatePassword(String value) {
    setState(() {
      final passwordRegex = RegExp(
          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

      if (value.length < 8) {
        _errorMessage = "Password must be at least 8 characters long";
      } else if (!passwordRegex.hasMatch(value)) {
        _errorMessage =
            "Password must include at least 1 letter, 1 number, and 1 special character";
      } else {
        _errorMessage = null; // No error
      }
    });
  }

  Future<void> _savePasswordAndProceed() async {
    if (_errorMessage != null || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid password.")),
      );
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUserData("password", _passwordController.text);

    await userProvider.registerUser(); // Register the user and save data

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Phoneauth()),
    );
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
            const SizedBox(height: 20),
            const Text(
              "Define your password",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF024550)),
            ),
            const SizedBox(height: 30),
            const Text(
              'It must be at least 8 characters, include 1 letter, 1 number, and 1 special character.',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                errorText: _errorMessage,
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
              ),
              onChanged: _validatePassword,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _savePasswordAndProceed,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
