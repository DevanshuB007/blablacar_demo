import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool _currentPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool get _isSaveButtonEnabled {
    return _currentPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change Password',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            const Text(
              'It must have at least 8 characters, 1 letter, 1 number, and 1 special character.',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 30),

            // Current Password Field
            TextField(
              controller: _currentPasswordController,
              obscureText: !_currentPasswordVisible,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                hintText: "Current password",
                suffixIcon: _currentPasswordController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          _currentPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentPasswordVisible = !_currentPasswordVisible;
                          });
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _newPasswordController,
              obscureText: !_newPasswordVisible,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                hintText: "New password",
                suffixIcon: _newPasswordController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          _newPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _newPasswordVisible = !_newPasswordVisible;
                          });
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // Confirm New Password Field
            TextField(
              controller: _confirmPasswordController,
              obscureText: !_confirmPasswordVisible,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                hintText: "Confirm new password",
                suffixIcon: _confirmPasswordController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 40),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: _isSaveButtonEnabled
                    ? () {
                        // Add save logic here
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save new password',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
