import 'package:flutter/material.dart';

class YourrideScr extends StatefulWidget {
  const YourrideScr({super.key});

  @override
  State<YourrideScr> createState() => _YourrideScrState();
}

class _YourrideScrState extends State<YourrideScr> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Simulate loading with a delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // Turn off the loader after delay
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the screen size using MediaQuery
    final size = MediaQuery.of(context).size;
    final double screenWidth = size.width;

    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                // Different behavior based on screen width
                bool isTabletOrLarger = constraints.maxWidth > 600;

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTabletOrLarger ? 40 : 16, // Adjust padding
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Responsive Image
                        Image.asset(
                          'assets/images/ride.png',
                          height: isTabletOrLarger
                              ? size.height * 0.5
                              : size.height * 0.4,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: size.height * 0.03),

                        // Responsive Title
                        Text(
                          'Your future travel plans \nwill appear here',
                          style: TextStyle(
                            color: const Color(0xFF004652),
                            fontSize: isTabletOrLarger ? 36 : 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.03),

                        // Responsive Subtitle
                        Text(
                          'Find the perfect ride from thousands of \ndestinations, or publish to share your travel costs.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: isTabletOrLarger ? 18 : 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
