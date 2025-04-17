import 'package:blablacar/Bottom_Navigationbar/profilescr/Account/payouts/addinfo.dart';
import 'package:flutter/material.dart';

class Payout extends StatefulWidget {
  const Payout({super.key});

  @override
  State<Payout> createState() => _PayoutState();
}

class _PayoutState extends State<Payout> {
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
            Image.asset('assets/images/space.png'),
            Text(
              'Your payouts will appear \nhere.',
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "you don't have any payouts yet. Complete a ride as a driver with a passenger first.",
            ),
            SizedBox(
              height: 90,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue,
              ),
              padding: EdgeInsets.all(1),
              child: ListTile(
                leading: Icon(Icons.add_circle_outline),
                title: Text(
                  "add my information",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addinfo()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
