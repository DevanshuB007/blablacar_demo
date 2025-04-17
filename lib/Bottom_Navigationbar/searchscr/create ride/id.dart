import 'package:flutter/material.dart';

class Id extends StatefulWidget {
  const Id({super.key});

  @override
  State<Id> createState() => _IdState();

  static unique() {}
}

class _IdState extends State<Id> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header text
              Text(
                'Friday, 27 December',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 40),

              // Ride details
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              const SizedBox(height: 8),
                              RideTimeWidget(
                                time: "09:40",
                                location: "Ahmedabad",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 10,
                color: Colors.grey.shade300,
              ),
              SizedBox(height: 16),

              // Passenger info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1 passenger",
                    style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "₹ 200.00",
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),
              Divider(
                thickness: 10,
                color: Colors.grey.shade300,
              ),

              // Driver information
              ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(
                      'assets/images/boy.png'), // Replace with your avatar image
                ),
                title: Text('biru'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Iskon Cross Road pickup point at AMD\nCar - Skoda Kushaq",
                          style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 16),
              // Additional details
              _infoRow(Icons.calendar_month,
                  "Your booking won't be confirmed until the driver approves your request"),
              _infoRow(Icons.people, "Max. 2 in the back"),
              _infoRow(Icons.directions_car, "SKODA KUSHAQ - Dark grey"),

              SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Handle contact action
                      },
                      icon: Icon(Icons.chat_bubble_outline, color: Colors.blue),
                      label: Text("Contact biru",
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Handle booking request
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.blue,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //     ),
                  //     child: Icon(Icons.calendar_month),

                  //     // Text("Request to book"),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 16),
              Divider(
                thickness: 10,
                color: Colors.grey.shade300,
              ),
              ListTile(
                leading: Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
                title: Text(
                  'Share ride',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.report_problem_outlined,
                  color: Colors.blue,
                ),
                title: Text(
                  'Report ride',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _rideInfoRow(String time, String location, String address) {
  //   return Row(
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             time,
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //           ),
  //           Text(
  //             location,
  //             style: TextStyle(fontSize: 14, color: Colors.grey[700]),
  //           ),
  //         ],
  //       ),
  //       SizedBox(width: 16),
  //       Expanded(
  //         child: Text(
  //           address,
  //           style: TextStyle(fontSize: 12, color: Colors.grey[600]),
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
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
          decoration: BoxDecoration(
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
