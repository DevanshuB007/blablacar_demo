import 'package:flutter/material.dart';

class Passanger extends StatefulWidget {
  const Passanger({super.key});

  @override
  State<Passanger> createState() => _PassangerState();
}

class _PassangerState extends State<Passanger> {
  int _seats = 2;

  void _incrementSeats() {
    setState(() {
      _seats++;
    });
  }

  void _decrementSeats() {
    if (_seats > 1) {
      setState(() {
        _seats--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Number of seats to \nbook',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _decrementSeats,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.blue,
                  iconSize: 50,
                ),
                Text(
                  '$_seats',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _incrementSeats,
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.blue,
                  iconSize: 50,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add navigation or confirmation logic here
        },
        backgroundColor: Colors.blue,
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
