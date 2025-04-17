import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Datapro extends StatefulWidget {
  const Datapro({super.key});

  @override
  State<Datapro> createState() => _DataproState();
}

class _DataproState extends State<Datapro> {
  final Uri _uri =
      Uri.parse("https://blog.blablacar.in/about-us/privacy-policy");

  Future<void> _launchUrl() async {
    if (!await launchUrl(_uri)) {
      throw Exception('Could not launch $_uri');
    }
  }

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
              ))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Protection',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text('Privacy Policy'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: _launchUrl,
            ),
          ],
        ),
      ),
    );
  }
}
