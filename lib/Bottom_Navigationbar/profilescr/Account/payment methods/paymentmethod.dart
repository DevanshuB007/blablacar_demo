import 'package:flutter/material.dart';

class Paymentmethod extends StatefulWidget {
  const Paymentmethod({super.key});

  @override
  State<Paymentmethod> createState() => _PaymentmethodState();
}

class _PaymentmethodState extends State<Paymentmethod> {
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
            Text(
              'payment methods',
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
                "The payment methods you saved when booking a ride will appear here.")
          ],
        ),
      ),
    );
  }
}
