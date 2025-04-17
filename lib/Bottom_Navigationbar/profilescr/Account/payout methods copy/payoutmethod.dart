import 'package:blablacar/Bottom_Navigationbar/profilescr/Account/payout%20methods%20copy/bankdetails.dart';
import 'package:flutter/material.dart';

class Payoutmethod extends StatefulWidget {
  const Payoutmethod({super.key});

  @override
  State<Payoutmethod> createState() => _PayoutmethodState();
}

class _PayoutmethodState extends State<Payoutmethod> {
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
              "To get your \nco-travellers' payments,please tell us how you want us to transfer the funds.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.account_balance_outlined),
              title: Text("Bank account"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Bankdetails()));
              },
            ),
            Spacer(),
            Text(
              "Data are collected by Comuto SA and transmitted to our payment provider  to enable you to receive your ppayouts.To know more and know your rights,you can take a look at the BlaBlaCar Privacy Policy.By Proceeding.you accept our payment Provider's Terms and conditions",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
