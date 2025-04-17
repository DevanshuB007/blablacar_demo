import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/add_edit_car/vehicalpro.dart';
import 'package:flutter/material.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/addvehicle/carcolor.dart';
import 'package:provider/provider.dart';

class Hyndai extends StatefulWidget {
  const Hyndai({super.key});

  @override
  State<Hyndai> createState() => _HyndaiState();
}

class _HyndaiState extends State<Hyndai> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  // Honda car models
  final List<String> hondaModels = [
    "Verna",
    "i20",
    "Grand i10"
        "Creta",
    "Venue",
    "Tucson",
    "Elantra",
    "Kona",
    "Santro",
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
              "What's your vehicle's \nmodel?",
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
                hintText: "Search model",
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

            //  Honda Model List
            Expanded(
              child: ListView.separated(
                itemCount: hondaModels.length,
                separatorBuilder: (context, index) => const Divider(indent: 10),
                itemBuilder: (context, index) {
                  final model = hondaModels[index];

                  // 🔍 Filter based on search query
                  if (_searchQuery.isNotEmpty &&
                      !model.toLowerCase().contains(_searchQuery)) {
                    return const SizedBox.shrink(); // Hide unmatched models
                  }

                  return ListTile(
                    title: Text(model),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      var provider =
                          Provider.of<VehicleProvider>(context, listen: false);
                      provider.setModel(model); // Set selected model
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Carcolor()),
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
