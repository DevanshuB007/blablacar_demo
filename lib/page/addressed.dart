import 'package:blablacar/page/passwordgen.dart';
import 'package:flutter/material.dart';

class Addressed extends StatefulWidget {
  const Addressed({super.key});

  @override
  State<Addressed> createState() => _AddressedState();
}

class _AddressedState extends State<Addressed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "How would you like to be addressed?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w400,
                color: Color(0xFF024550),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Miss/Madam',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.grey),
                      onTap: () {
                        // Email sign up action
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Passwordgen()));
                      },
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 1),
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'sir',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Passwordgen()));
                      },
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 1),
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        "i'd rather not say",
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Passwordgen()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
