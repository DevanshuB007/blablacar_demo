import 'package:blablacar/Bottom_Navigationbar/profilescr/Account/rating/given.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Account/rating/received.dart';
import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Ratings',
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // TabBar for navigation
              const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: 'Received'),
                  Tab(text: 'Given'),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              // TabBarView for displaying content
              Expanded(
                child: TabBarView(
                  children: [
                    Received(),
                    Given(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
