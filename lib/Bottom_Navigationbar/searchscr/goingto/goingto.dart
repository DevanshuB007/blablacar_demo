import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Goingto extends StatefulWidget {
  const Goingto({super.key});

  @override
  State<Goingto> createState() => _GoingtoState();
}

class _GoingtoState extends State<Goingto> {
  String currentLocation = "Fetching location...";

  // Function to get the current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        currentLocation = "Location services are disabled.";
      });
      print(currentLocation);
      return;
    }

    // Request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          currentLocation = "Location permissions are denied.";
        });
        print(currentLocation);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        currentLocation =
            "Location permissions are permanently denied, we cannot access location.";
      });
      print(currentLocation);
      return;
    }

    // Get current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

      // Convert coordinates to address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Extract the first address from the list
      Placemark place = placemarks[0];
      String fullAddress =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";

      // Update the state with the full address
      setState(() {
        currentLocation = fullAddress;
      });

      // Print the full address
      print("Current Address: $fullAddress");
    } catch (e) {
      print("Error: $e");
      setState(() {
        currentLocation = "Failed to get the address.";
      });
    }
  }

  // Function to show the location search modal
  void _showSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: 'Enter the full location',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                  onChanged: (value) {
                    // Handle search query input
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.my_location),
                  title: const Text('Use Current Location'),
                  subtitle: Text(currentLocation),
                  onTap: () async {
                    await _getCurrentLocation();
                    Navigator.pop(context); // Close the modal
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Enter the full location',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  prefixIcon: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
                onChanged: (value) {
                  // Handle search query input
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.my_location),
                title: const Text('Use Current Location'),
                subtitle: Text(currentLocation),
                onTap: () async {
                  await _getCurrentLocation(); // Fetch current location
                  Navigator.pop(context,
                      currentLocation); // Return the location to the previous page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
