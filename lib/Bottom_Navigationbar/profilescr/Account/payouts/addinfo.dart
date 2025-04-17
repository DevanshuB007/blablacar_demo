import 'package:flutter/material.dart';

class Addinfo extends StatefulWidget {
  const Addinfo({super.key});

  @override
  State<Addinfo> createState() => _AddinfoState();
}

class _AddinfoState extends State<Addinfo> {
  String? _selectedCountry = 'India';
  final List<String> _countries = ['India', 'USA', 'UK', 'Germany', 'France'];

  void _selectCountry() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _countries.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_countries[index]),
                  onTap: () {
                    setState(() {
                      _selectedCountry = _countries[index];
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add a payout method',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),

            // Country selection button
            GestureDetector(
              onTap: _selectCountry,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedCountry ?? 'Select a country',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              children: const [
                Icon(
                  Icons.warning_amber_rounded,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    'This is the place where you opened your \naccount.',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'This country is not supported yet. Please select another one to receive your payouts.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            const Spacer(),

            const Text(
              'Data are collected by Comuto SA and transmitted to our payment provider to enable you to receive your payouts. To know more and know your rights, you can take a look at the BlaBlaCar Privacy Policy. By proceeding, you accept our payment provider’s Terms and Conditions.',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
