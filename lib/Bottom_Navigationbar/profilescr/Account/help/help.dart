import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final Uri _uri = Uri.parse(
      "https://support.blablacar.com/s/topic/0TOSZ00000014ba4AA/how-blablacar-works?language=en_IN");

  Future<void> _launchUrl() async {
    if (!await launchUrl(_uri)) {
      throw Exception('Could not launch $_uri');
    }
  }

  final Uri uri = Uri.parse("https://support.blablacar.com/s/?language=en_IN");

  Future<void> help() async {
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
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Help",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            ListTile(
              title: Text('How it works'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: _launchUrl,
            ),
            Divider(
              indent: 10,
            ),
            ListTile(
              title: Text('Help Centre'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: help,
            ),
            Divider(
              indent: 10,
            ),
            ListTile(
              title: Text('insurance'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: help,
            ),
            Divider(
              indent: 10,
            ),
            ListTile(
              title: Text('Contact Us'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: _launchUrl,
            ),
          ],
        ),
      ),
    );
  }
}
