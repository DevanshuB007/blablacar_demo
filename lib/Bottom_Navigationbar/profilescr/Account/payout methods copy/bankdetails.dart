import 'package:flutter/material.dart';

class Bankdetails extends StatefulWidget {
  const Bankdetails({super.key});

  @override
  State<Bankdetails> createState() => _BankdetailsState();
}

class _BankdetailsState extends State<Bankdetails> {
  final TextEditingController _accountHolderController =
      TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _bicController = TextEditingController();

  String? _selectedCountry;

  bool get _isSaveButtonEnabled {
    return _selectedCountry != null &&
        _accountHolderController.text.isNotEmpty &&
        _bankNameController.text.isNotEmpty &&
        _ibanController.text.isNotEmpty &&
        _bicController.text.isNotEmpty;
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
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your bank account \ndetails",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),

              // Country Selection ListTile
              ListTile(
                title: const Text("Choose a country"),
                subtitle: Text(
                  _selectedCountry ?? "Andorra",
                  style: const TextStyle(color: Colors.blue),
                ),
                // trailing: const Icon(Icons.arrow_drop_down),
                onTap: () async {
                  final selected = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return CountrySelectionDialog(
                        countries: [
                          'Andorra',
                          'Austria',
                          'Belgium',
                          'Bulgaria',
                          'Croatia',
                          'Cyprus',
                          'Czechia',
                          'Denmark',
                          'Estonia',
                          'Finlan',
                          'France',
                          'Germany',
                          'Gibraltar',
                          'Greece',
                          'Hungary',
                          'Iceland',
                          'ireland',
                          'italy',
                          'Latvia',
                          'Liechtenstein',
                          'Lithuania',
                          'Luxembourg',
                          'Malta',
                          'Monaco',
                          'Netherlands',
                          'Norway',
                          'Poland',
                          'Portugal',
                          'Romania',
                          'San Marino',
                          'Slovakia',
                          'Slovenia',
                          'Sweden',
                          'Switzerland',
                          'United Kingdom',
                        ],
                        selectedCountry: _selectedCountry,
                      );
                    },
                  );
                  if (selected != null) {
                    setState(() {
                      _selectedCountry = selected;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Account Holder TextField
              TextField(
                controller: _accountHolderController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Account holder",
                ),
              ),
              const SizedBox(height: 20),

              // Bank Name TextField
              TextField(
                controller: _bankNameController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Bank name",
                ),
              ),
              const SizedBox(height: 20),

              // IBAN TextField
              TextField(
                controller: _ibanController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "IBAN",
                ),
              ),
              const SizedBox(height: 20),

              // BIC TextField
              TextField(
                controller: _bicController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "BIC",
                ),
              ),
              const SizedBox(height: 40),

              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: _isSaveButtonEnabled
                      ? () {
                          // Add save logic here
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Country Selection Dialog
class CountrySelectionDialog extends StatelessWidget {
  final List<String> countries;
  final String? selectedCountry;

  const CountrySelectionDialog({
    Key? key,
    required this.countries,
    this.selectedCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: countries
              .map(
                (country) => ListTile(
                  title: Text(country),
                  onTap: () {
                    Navigator.pop(context, country);
                  },
                  selected: selectedCountry == country,
                  selectedTileColor: Colors.grey.shade200,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
