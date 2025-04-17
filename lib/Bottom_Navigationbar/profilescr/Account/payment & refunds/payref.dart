import 'package:flutter/material.dart';

class Payref extends StatefulWidget {
  const Payref({super.key});

  @override
  State<Payref> createState() => _PayrefState();
}

class _PayrefState extends State<Payref> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
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
            Image.asset('assets/images/1.png', fit: BoxFit.contain),
            Text(
              "Looks like you have't made any online payments in the last 2 years",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
