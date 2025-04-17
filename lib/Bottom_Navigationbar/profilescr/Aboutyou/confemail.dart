import 'package:flutter/material.dart';

class Confemail extends StatefulWidget {
  const Confemail({super.key});

  @override
  State<Confemail> createState() => _ConfemailState();
}

class _ConfemailState extends State<Confemail> {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Image
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.05, // Adjust padding based on height
                right: screenWidth * 0.2, // Adjust padding based on width
              ),
              child: Image.asset(
                'assets/images/men.png', // Replace with your image path
                width: screenWidth * 0.7, // Adjust width dynamically
                height: screenHeight * 0.25, // Adjust height dynamically
                fit: BoxFit.contain,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Text(
                    "We've sent a verification \nlink to your email address \nPlease check your inbox",
                    style: TextStyle(
                      fontSize: screenWidth * 0.07, // Responsive font size
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center, // Align text to center
                  ),
                ),
              ],
            ),
            // Bottom Button
            Padding(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.05,
                top: screenHeight * 0.1,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle button click
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button background color
                  foregroundColor: Colors.blue, // Button text color
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.2, // Button horizontal padding
                    vertical: screenHeight * 0.02, // Button vertical padding
                  ),
                ),
                child: Text(
                  "Got it",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Responsive font size
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
