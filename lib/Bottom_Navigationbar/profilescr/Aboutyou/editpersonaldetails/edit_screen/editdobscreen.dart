import 'package:flutter/material.dart';

class Editdobscreen extends StatefulWidget {
  final String? currentFirstName;
  const Editdobscreen({Key? key, this.currentFirstName}) : super(key: key);

  @override
  State<Editdobscreen> createState() => _EditdobState();
}

class _EditdobState extends State<Editdobscreen> {
  late TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _dobController = TextEditingController(text: widget.currentFirstName ?? '');
  }

  @override
  void dispose() {
    _dobController.dispose();
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "What's your date of birth?",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF024550),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).nextFocus(); // Move to next field
              },
              onChanged: (value) {
                // Handle changes if needed
              },
              controller: _dobController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: "DD/MM/YYYY",
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.grey,
                    size: 30,
                  ), // Clear icon
                  onPressed: () {
                    _dobController.clear();
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            // const SizedBox(height: 20),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _dobController.text.trim());
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
            const SizedBox(height: 20),

            // TextField(
            //   controller: _dobController,
            //   decoration: const InputDecoration(labelText: "First Name"),
            // ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context, _dobController.text.trim());
            //   },
            //   child: const Text("Save"),
            // ),
          ],
        ),
      ),
    );
  }
}
