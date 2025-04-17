import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/add_edit_car/vehicalpro.dart';

class Carcolor extends StatefulWidget {
  const Carcolor({super.key});

  @override
  State<Carcolor> createState() => _CarcolorState();
}

class _CarcolorState extends State<Carcolor> {
  String? _selectedColor;
  bool _isSaving = false;
  final String userId =
      "your_user_id_here"; // Replace with actual user ID logic

  final List<Map<String, dynamic>> _colors = [
    {"label": "Black", "color": Colors.black},
    {"label": "White", "color": Colors.white},
    {"label": "Dark Grey", "color": Colors.grey.shade700},
    {"label": "Grey", "color": Colors.grey},
    {"label": "Red", "color": Colors.red},
    {"label": "Blue", "color": Colors.blue},
    {"label": "Green", "color": Colors.green},
    {"label": "Brown", "color": Colors.brown},
    {"label": "Orange", "color": Colors.orange},
    {"label": "Yellow", "color": Colors.yellow},
    {"label": "Purple", "color": Colors.purple},
    {"label": "Pink", "color": Colors.pink},
  ];

  // Future<void> _saveColor() async {
  //   try {
  //     if (_selectedColor == null) return;

  //     setState(() => _isSaving = true);

  //     var provider = Provider.of<VehicleProvider>(context, listen: false);
  //     provider.setColor(_selectedColor!);

  //     print(
  //         " Saving Data: Brand=${provider.selectedBrand}, Model=${provider.selectedModel}, Color=${provider.selectedColor}");

  //     await provider.saveVehicleData();

  //     setState(() => _isSaving = false);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Vehicle data saved successfully!')),
  //     );

  //     Navigator.popUntil(context, (route) => route.isFirst);
  //   } catch (e) {
  //     print("Failed to save vehicle: $e");

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to save data: $e')),
  //     );
  //   }

  //   setState(() => _isSaving = false);
  // }
  Future<void> _saveColor() async {
    if (_selectedColor == null) return;

    setState(() => _isSaving = true);

    var provider = Provider.of<VehicleProvider>(context, listen: false);
    provider.setColor(_selectedColor!);

    print(
        " Saving Data: Brand=${provider.selectedBrand}, Model=${provider.selectedModel}, Color=${provider.selectedColor}");

    //  Fetch user ID before saving
    String? userId = await provider.getUserId();

    if (userId == null) {
      print(" Error: User not logged in.");
      setState(() => _isSaving = false);
      return;
    }

    //  Save data
    await provider.saveVehicleData();

    setState(() => _isSaving = false);

    //  Show success message
    // ScaffoldMessenger.of(context).showSnackBar(s
    //   const SnackBar(content: Text(' Vehicle data saved successfully!')),
    // );
    //  Navigate back to the previous screen
    Navigator.popUntil(context, (route) => route.isFirst);
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What color is your vehicle?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _colors.length,
                itemBuilder: (context, index) {
                  final colorOption = _colors[index];
                  final label = colorOption["label"];
                  final color = colorOption["color"];

                  return ListTile(
                    leading: Radio<String>(
                      value: label,
                      groupValue: _selectedColor,
                      onChanged: (newValue) {
                        setState(() => _selectedColor = newValue);
                      },
                      activeColor: color,
                    ),
                    title: Text(label, style: const TextStyle(fontSize: 16)),
                    trailing: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black54, width: 1),
                      ),
                    ),
                    onTap: () => setState(() => _selectedColor = label),
                  );
                },
              ),
            ),
            if (_selectedColor != null)
              Center(
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveColor,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  child: _isSaving
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          'Save',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
