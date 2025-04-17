import 'package:blablacar/page/addressed.dart';
import 'package:blablacar/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Dobscreen extends StatefulWidget {
  const Dobscreen({super.key});

  @override
  _DobscreenState createState() => _DobscreenState();
}

class _DobscreenState extends State<Dobscreen> {
  final TextEditingController _dobController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default is today's date
      firstDate: DateTime(1900), // Minimum date selectable
      lastDate: DateTime.now(), // Maximum date selectable
    );

    if (selectedDate != null) {
      setState(() {
        // Format the selected date as "DD/MM/YYYY"
        _dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Adjust layout for keyboard
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to start
            children: [
              const SizedBox(height: 20),
              const Text(
                "What's your date of birth?",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _dobController,
                  readOnly: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "DD/MM/YYYY",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Icon(Icons.calendar_today,
                          color: Colors.grey.shade600),
                    ),
                  ),
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your date of birth.";
                    }
                    // Validate date format (DD/MM/YYYY)
                    final RegExp datePattern = RegExp(
                        r"^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$");
                    if (!datePattern.hasMatch(value)) {
                      return "Enter a valid date in DD/MM/YYYY format.";
                    }
                    return null;
                  },
                  onTap: () {
                    // Open DatePicker if needed
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Provider.of<UserProvider>(context, listen: false)
                .setUserData("dob", _dobController.text);

            // Navigate to next screen
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Addressed()));
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
