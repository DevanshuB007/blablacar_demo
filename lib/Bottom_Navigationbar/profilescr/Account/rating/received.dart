import 'package:flutter/material.dart';

class Received extends StatefulWidget {
  const Received({super.key});

  @override
  State<Received> createState() => _ReceivedState();
}

class _ReceivedState extends State<Received> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/rating.png', // Replace with your image path
            width: 300, // 60% of screen width
            height: 300, // 30% of screen height
            fit: BoxFit.cover,
          ),
          SizedBox(height: screenHeight * 0.05),
          Text(
            "You haven't received any rating yet",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.06, // Dynamically adjust font size
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
