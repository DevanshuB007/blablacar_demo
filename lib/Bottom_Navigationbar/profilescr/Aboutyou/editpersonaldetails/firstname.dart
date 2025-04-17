import 'package:flutter/material.dart';

class Firstname extends StatefulWidget {
  const Firstname({super.key});

  @override
  State<Firstname> createState() => _FirstnameState();
}

class _FirstnameState extends State<Firstname> {
  final TextEditingController _firstNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    // _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "What's your first \n name?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: "First name",
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: _firstNameController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _firstNameController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) {
                setState(() {}); // Update UI when text changes
              },
            ),
            const SizedBox(height: 480),
            Center(
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
