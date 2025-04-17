import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/add_edit_car/deletecar.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/add_edit_car/editcardetails.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/add_edit_car/vehicalpro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Editcar extends StatefulWidget {
  final String carId;

  const Editcar({super.key, required this.carId});

  @override
  State<Editcar> createState() => _EditcarState();
}

class _EditcarState extends State<Editcar> {
  @override
  void initState() {
    super.initState();
    final vehicleProvider =
        Provider.of<VehicleProvider>(context, listen: false);
    vehicleProvider.selectedCarId = widget.carId;
  }

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, color: Colors.blue, size: 30),
        ),
      ),
      body: FutureBuilder(
        future: vehicleProvider.getCarDetails(widget.carId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching car details'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    title:
                        Text(vehicleProvider.selectedBrand ?? 'No Brand Name'),
                    subtitle:
                        Text(vehicleProvider.selectedColor ?? 'No Color Name'),
                  ),
                  ListTile(
                    title: const Text(
                      'Edit Info',
                      style: TextStyle(color: Colors.cyan),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditCarDetailsScreen(carId: widget.carId),
                        ),
                      );
                    },
                  ),
                  const Divider(indent: 16),
                  ListTile(
                    title: const Text(
                      'Delete Vehicle',
                      style: TextStyle(color: Colors.cyan),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Deletecar(carId: widget.carId),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
