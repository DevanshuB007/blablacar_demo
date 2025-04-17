import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/add_edit_car/vehicalpro.dart';

class EditCarDetailsScreen extends StatefulWidget {
  final String carId;

  const EditCarDetailsScreen({super.key, required this.carId});

  @override
  State<EditCarDetailsScreen> createState() => _EditCarDetailsScreenState();
}

class _EditCarDetailsScreenState extends State<EditCarDetailsScreen> {
  String? selectedBrand;
  String? selectedModel;
  String? selectedColor;

  bool isLoading = true;
  bool _isSaving = false;

  List<String> colorList = [
    "Black",
    "White",
    "Dark Grey",
    "Grey",
    "Red",
    "Blue",
    "Green",
    "Brown",
    "Orange",
    "Yellow",
    "Purple",
    "Pink"
  ];

  Map<String, List<String>> carModels = {
    'TATA': [
      "Tigor",
      "Nexon",
      "Harrier",
      "Safari",
      "Altroz",
      "Punch",
    ],
    'MARUTI': [
      "Alto",
      "Baleno",
      "Celerio",
      "Dzire",
      "Ertiga",
      "Ignis",
      "Swift",
      "Vitara Brezza",
    ],
    'HYUNDAI': [
      "Verna",
      "i20",
      "Grand i10"
          "Creta",
      "Venue",
      "Tucson",
      "Elantra",
      "Kona",
      "Santro",
    ],
    'HONDA': ["Accord", "CIVIC", "CR-V", "CITY", "JAZZ"],
  };

  @override
  void initState() {
    super.initState();
    fetchCarDetails();
  }

  Future<void> fetchCarDetails() async {
    final vehicleProvider =
        Provider.of<VehicleProvider>(context, listen: false);
    await vehicleProvider.getCarDetails(widget.carId);

    setState(() {
      selectedBrand = vehicleProvider.selectedBrand;
      selectedModel = vehicleProvider.selectedModel;
      selectedColor = vehicleProvider.selectedColor;
      isLoading = false;
    });
  }

  Future<void> updateCarDetails() async {
    final vehicleProvider =
        Provider.of<VehicleProvider>(context, listen: false);
    setState(() {
      _isSaving = true;
    });

    try {
      await vehicleProvider.updateVehicle(
        carId: widget.carId,
        brand: selectedBrand ?? '',
        model: selectedModel ?? '',
        color: selectedColor ?? '',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Car Details Updated Successfully!')),
      );

      Navigator.pop(context);
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Car Details')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Brand Dropdown
                  DropdownButtonFormField<String>(
                    value: carModels.keys.contains(selectedBrand)
                        ? selectedBrand
                        : null,
                    items: carModels.keys
                        .map((brand) => DropdownMenuItem(
                              value: brand,
                              child: Text(brand),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBrand = value;
                        selectedModel = null; // Reset Model when Brand change
                      });
                    },
                    decoration: InputDecoration(labelText: 'Select Brand'),
                  ),

                  SizedBox(height: 10),

                  // Model Dropdown
                  DropdownButtonFormField<String>(
                    value:
                        (carModels[selectedBrand] ?? []).contains(selectedModel)
                            ? selectedModel
                            : null,
                    items: (carModels[selectedBrand] ?? [])
                        .map((model) => DropdownMenuItem(
                              value: model,
                              child: Text(model),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedModel = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Select Model'),
                  ),

                  SizedBox(height: 10),

                  // Color Dropdown
                  DropdownButtonFormField<String>(
                    value: colorList.contains(selectedColor)
                        ? selectedColor
                        : null,
                    items: colorList
                        .map((color) => DropdownMenuItem(
                              value: color,
                              child: Text(color),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedColor = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Select Color'),
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: updateCarDetails,
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
                            'Update Car',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
