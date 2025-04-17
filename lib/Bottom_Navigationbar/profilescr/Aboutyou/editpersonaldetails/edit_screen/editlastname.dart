import 'package:flutter/material.dart';

class Editlastnamescreen extends StatefulWidget {
  final String? currentFirstName;
  const Editlastnamescreen({Key? key, this.currentFirstName}) : super(key: key);

  @override
  State<Editlastnamescreen> createState() => _EditLastNameState();
}

class _EditLastNameState extends State<Editlastnamescreen> {
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _lastNameController =
        TextEditingController(text: widget.currentFirstName ?? '');
  }

  @override
  void dispose() {
    _lastNameController.dispose();
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
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "What's your Last name?",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF024550),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).nextFocus(); // Move to next field
              },
              onChanged: (value) {
                // Handle changes if needed
              },
              controller: _lastNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: "Last name",
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.grey,
                    size: 30,
                  ), // Clear icon
                  onPressed: () {
                    _lastNameController.clear();
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
            // const SizedBox(height: 60),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _lastNameController.text.trim());
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
            //   controller: _lastNameController,
            //   decoration: const InputDecoration(labelText: "First Name"),
            // ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context, _lastNameController.text.trim());
            //   },
            //   child: const Text("Save"),
            // ),
          ],
        ),
      ),
    );
  }
}
