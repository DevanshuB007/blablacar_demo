import 'package:blablacar/Bottom_Navigationbar/searchscr/create%20ride/createride.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/goingto/goingto.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/leaving_from/leavingfrom.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/passanger.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/search_screen/search_screen.dart';
import 'package:blablacar/Bottom_Navigationbar/searchscr/today.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchScr extends StatefulWidget {
  const SearchScr({super.key});

  @override
  State<SearchScr> createState() => _SearchScrState();
}

class _SearchScrState extends State<SearchScr> {
  DateTime? _selectedDate;
  String selectedLocation = "Leaving From";

  void updateLocation(String newLocation) {
    setState(() {
      selectedLocation = newLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 650,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/logscr.JPG',
                    fit: BoxFit.fill,
                    height: 500,
                    width: double.infinity,
                  ),
                ),
                // Top Image (placed over the background image)
                const Positioned(
                  top: 50, // Adjust the position from the top as needed
                  left: 50, // Adjust the position from the left as needed
                  child: Text(
                    'Your pick of rides at \n low Prices ',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 310,
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
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: const Icon(Icons.schedule),
                title: Text(
                  selectedLocation,
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: const Text(''),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Createride()));
                  // Handle tap on ride details
                },
              ),
            ), // Search form
          ],
        ),
      ),
    );
  }
}
