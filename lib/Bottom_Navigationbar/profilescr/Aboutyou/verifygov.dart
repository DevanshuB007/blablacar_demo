import 'package:flutter/material.dart';

class Verifygov extends StatefulWidget {
  const Verifygov({super.key});

  @override
  State<Verifygov> createState() => _VerifygovState();
}

class _VerifygovState extends State<Verifygov> {
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
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Which document \nwould you like to upload?',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text('Passport'),
              subtitle: Text('Face photo page'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to the next screen or perform an action
              },
            ),
            Divider(
              indent: 15,
            ),
            ListTile(
              title: Text('Aaddhaar card'),
              subtitle: Text('Front and back'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            Divider(
              indent: 15,
            ),
            ListTile(
              title: Text('PAN card'),
              subtitle: Text('Front and back'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            Spacer(),
            Text(
              'The data collected by Comuti SA is necessary for verifying your identity.For more information and to  exercise your rights.see our Privacy Policy',
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
