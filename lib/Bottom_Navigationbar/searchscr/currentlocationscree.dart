// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class CurrentLocationMapScreen extends StatefulWidget {
//   @override
//   _CurrentLocationMapScreenState createState() =>
//       _CurrentLocationMapScreenState();
// }

// class _CurrentLocationMapScreenState extends State<CurrentLocationMapScreen> {
//   late GoogleMapController mapController;
//   LatLng? _currentLatLng;

//   @override
//   void initState() {
//     super.initState();
//     _determinePosition();
//   }

//   Future<void> _determinePosition() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied.');
//     }

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         return Future.error('Location permissions are denied.');
//       }
//     }

//     final position = await Geolocator.getCurrentPosition();
//     setState(() {
//       _currentLatLng = LatLng(position.latitude, position.longitude);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Your Current Location")),
//       body: _currentLatLng == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               onMapCreated: (GoogleMapController controller) {
//                 mapController = controller;
//               },
//               initialCameraPosition: CameraPosition(
//                 target: _currentLatLng!,
//                 zoom: 15.0,
//               ),
//               markers: {
//                 Marker(
//                   markerId: const MarkerId("currentLocation"),
//                   position: _currentLatLng!,
//                   infoWindow: const InfoWindow(title: "You are here"),
//                 ),
//               },
//             ),
//     );
//   }
// }
