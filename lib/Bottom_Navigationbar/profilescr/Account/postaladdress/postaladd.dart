import 'package:blablacar/Bottom_Navigationbar/profilescr/Account/postaladdress/address.dart';
import 'package:flutter/material.dart';

class Postaladd extends StatefulWidget {
  const Postaladd({super.key});

  @override
  State<Postaladd> createState() => _PostaladdState();
}

class _PostaladdState extends State<Postaladd> {
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
              'Postal address',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline, color: Colors.blue),
              title: const Text(
                'Add Profile picture',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Address()));
              },
            ),
            Divider(
              indent: 10,
            ),
            Text(
                "We promise we'll only use it to send you ggifts and deals from us or our partners ")
          ],
        ),
      ),
    );
  }
}
