import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Dobscr extends StatefulWidget {
  const Dobscr({super.key});

  @override
  State<Dobscr> createState() => _DobscrState();
}

class _DobscrState extends State<Dobscr> {
  // final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "What's your date of\n birth..?",
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF024550),
              ),
              // TextStyle(
              //   fontSize: 28,
              //   fontWeight: FontWeight.w400,
              //   color: Colors.black,
              // ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _dobController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Allows only digits
                _DateInputFormatter(), // Custom formatter for DD/MM/YYYY
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: "DD/MM/YYYY",
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: _dobController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _dobController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) {
                setState(() {}); // Update UI when text changes
              },
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // // Validate the entered date format
                  // final dateParts = _dobController.text.split('/');
                  // if (dateParts.length == 3) {
                  //   final day = int.tryParse(dateParts[0]);
                  //   final month = int.tryParse(dateParts[1]);
                  //   final year = int.tryParse(dateParts[2]);

                  //   if (day != null &&
                  //       month != null &&
                  //       year != null &&
                  //       day > 0 &&
                  //       day <= 31 &&
                  //       month > 0 &&
                  //       month <= 12 &&
                  //       year > 1900) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('Date of Birth Saved')),
                  //     );
                  //   } else {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('Invalid Date Format')),
                  //     );
                  //   }
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Invalid Date Format')),
                  //   );
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    // Remove any non-digit characters
    String cleanedText = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Add slashes at the correct positions
    if (cleanedText.length > 2) {
      cleanedText =
          '${cleanedText.substring(0, 2)}/${cleanedText.substring(2)}';
    }
    if (cleanedText.length > 5) {
      cleanedText =
          '${cleanedText.substring(0, 5)}/${cleanedText.substring(5)}';
    }

    // Limit to DD/MM/YYYY format
    if (cleanedText.length > 10) {
      cleanedText = cleanedText.substring(0, 10);
    }

    return TextEditingValue(
      text: cleanedText,
      selection: TextSelection.collapsed(offset: cleanedText.length),
    );
  }
}
