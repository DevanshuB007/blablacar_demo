import 'package:flutter/material.dart';

class Editemailscreen extends StatefulWidget {
  final String? currentFirstName;
  const Editemailscreen({Key? key, this.currentFirstName}) : super(key: key);

  @override
  State<Editemailscreen> createState() => _EditemailState();
}

class _EditemailState extends State<Editemailscreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController =
        TextEditingController(text: widget.currentFirstName ?? '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 30,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What's your email?",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF024550),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).nextFocus(); // Move to next field
                },
                onChanged: (value) {
                  setState(() {}); // Update the state to enable/disable button
                },
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "Email",
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.grey,
                      size: 30,
                    ), // Clear icon
                    onPressed: () {
                      _emailController.clear();
                    },
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            // const SizedBox(height: 20),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _emailController.text.trim());
                },
                child: const Text("Save",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // TextField(
            //   controller: _emailController,
            //   decoration: const InputDecoration(labelText: "First Name"),
            // ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context, _emailController.text.trim());
            //   },
            //   child: const Text("Save"),
            // ),
          ],
        ),
      ),
    );
  }
}
