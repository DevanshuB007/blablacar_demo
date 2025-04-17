import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/add_edit_car/vehicalpro.dart';
import 'package:flutter/material.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/addvehicle/ford.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/addvehicle/honda.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/addvehicle/hyndai.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/addvehicle/maruti.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/addvehicle/tata.dart';
import 'package:provider/provider.dart';

class Addvehicle extends StatefulWidget {
  const Addvehicle({super.key});

  @override
  State<Addvehicle> createState() => _AddvehicleState();
}

class _AddvehicleState extends State<Addvehicle> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  // Car brands and their respective screens
  final List<Map<String, dynamic>> carBrands = [
    {"name": "FORD", "screen": const Ford()},
    {"name": "HONDA", "screen": const Honda()},
    {"name": "HYUNDAI", "screen": const Hyndai()},
    {"name": "MARUTI", "screen": const Maruti()},
    {"name": "TATA", "screen": const Tata()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What's your vehicle's \nbrand?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),

            // 🔍 Search Bar
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Search car brand",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.separated(
                itemCount: carBrands.length,
                separatorBuilder: (context, index) => const Divider(indent: 10),
                itemBuilder: (context, index) {
                  final brand = carBrands[index];

                  // 🔍 Filter based on search query
                  if (_searchQuery.isNotEmpty &&
                      !brand["name"].toLowerCase().contains(_searchQuery)) {
                    return const SizedBox.shrink(); // Hide unmatched brands
                  }

                  return ListTile(
                    title: Text(brand["name"]),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      var provider =
                          Provider.of<VehicleProvider>(context, listen: false);
                      provider.setCompany(brand["name"]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => brand["screen"]),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
