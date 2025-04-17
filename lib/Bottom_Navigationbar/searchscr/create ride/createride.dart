import 'package:blablacar/Bottom_Navigationbar/searchscr/create%20ride/id.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/goingto/goingto.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/leaving_from/leavingfrom.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/passanger.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/search_screen/search_screen.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/today.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Createride extends StatefulWidget {
  const Createride({super.key});

  @override
  State<Createride> createState() => _CreaterideState();
}

class _CreaterideState extends State<Createride> {
  DateTime? _selectedDate;
  String selectedLocation = "Leaving From";

  void updateLocation(String newLocation) {
    setState(() {
      selectedLocation = newLocation;
    });
  }

  void _showSearchDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Search",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenheight = MediaQuery.of(context).size.height;

        return Align(
          alignment: Alignment.topCenter, // Align the dialog to the top
          child: Material(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Edit Your Search',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 350,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.circle_outlined),
                            title: Text(
                                selectedLocation), // Display the address here
                            onTap: () async {
                              final location = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Leavingfrom(),
                                ),
                              );
                              if (location != null) {
                                // If a location is selected, update the location
                                updateLocation(location);
                              }
                            },
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.circle_outlined),
                            title: const Text('Going to'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Goingto()));
                              // Handle "Going to" action
                            },
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.calendar_month_outlined),
                            title: Text(
                              _selectedDate == null
                                  ? 'Today'
                                  : DateFormat('E d MMM')
                                      .format(_selectedDate!),
                              style: const TextStyle(fontSize: 15),
                            ),
                            onTap: () async {
                              // Navigate to Todaydate and wait for the result
                              DateTime? result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Todaydate()),
                              );

                              if (result != null) {
                                setState(() {
                                  _selectedDate =
                                      result; // Update with selected date
                                });
                              }
                            },
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text('1 passenger'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Passanger()));
                              // Handle passenger count selection
                            },
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue, // Button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchScreen()));
                                // Handle search action
                              },
                              child: const Text(
                                'Search',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1), // Start from above the screen
            end: Offset.zero,
          ).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => _showSearchDialog(context), // Opens the search modal
          child: TextField(
            readOnly: true, // Makes the text field non-editable
            onTap: () => _showSearchDialog(context), // Opens the search modal
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  print('Back button work');
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              // focusedBorder: OutlineInputBorder(
              //   borderSide: const BorderSide(color: Colors.grey),
              // ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ), // Text style
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.keyboard_arrow_up),
            title: Text(
              "Earlier departures",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.045,
              ),
            ),
            tileColor: Colors.white,
          ),
          const SizedBox(height: 150),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Tomorrow',
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Id()),
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RideTimeWidget(
                              time: "06:00",
                              location: "Rajkot",
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            RideTimeWidget(
                              time: "09:40",
                              location: "Ahmedabad",
                            ),
                          ],
                        ),
                        Text(
                          "₹ 550.00",
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const Divider(),
                    Row(
                      children: [
                        const Icon(Icons.car_rental, size: 30),
                        SizedBox(width: screenWidth * 0.03),
                        const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Text(
                          "Devendra",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.electric_bolt_sharp),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: const BorderSide(color: Colors.blue),
                ),
              ),
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.015,
                ),
                child: const Text("Create a ride alert"),
              ),
            ),
          ),
          Spacer(),
          SizedBox(height: screenHeight * 0.10),
          const Divider(thickness: 9),
          ListTile(
            leading: const Icon(Icons.keyboard_arrow_down),
            title: Text(
              "Later departures",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.045,
              ),
            ),
            tileColor: Colors.white,
          ),
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }
}

class RideTimeWidget extends StatelessWidget {
  final String time;
  final String location;

  const RideTimeWidget({
    Key? key,
    required this.time,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          height: screenWidth * 0.02,
          width: screenWidth * 0.02,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "$time  $location",
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
