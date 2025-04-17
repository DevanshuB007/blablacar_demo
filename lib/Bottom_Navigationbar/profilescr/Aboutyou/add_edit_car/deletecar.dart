import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/add_edit_car/vehicalpro.dart';

class Deletecar extends StatelessWidget {
  final String carId; // Car ID to delete
  const Deletecar({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    final vehicleProvider =
        Provider.of<VehicleProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              "Deleting a car from your profile might make it harder for passengers to find you at the meeting point.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF004D4F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //  Cancel Button
            IconButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              icon: const Icon(Icons.close, color: Colors.white),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                padding: const EdgeInsets.all(15),
              ),
            ),

            // 🗑 Delete Button
            ElevatedButton(
              onPressed: () {
                print("Deleting car with ID: $carId");
                final vehicleProvider =
                    Provider.of<VehicleProvider>(context, listen: false);
                vehicleProvider.deleteVehicle(context, carId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text("Delete vehicle",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
