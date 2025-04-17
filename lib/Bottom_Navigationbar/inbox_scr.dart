import 'package:flutter/material.dart';

class InboxScr extends StatefulWidget {
  const InboxScr({super.key});

  @override
  State<InboxScr> createState() => _InboxScrState();
}

class _InboxScrState extends State<InboxScr> {
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
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'inbox',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF024550),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "No messages right now.Bookk or publish a ride to contact other members.if you have already an upcoming ride,feel to contact who you're travelling with!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
