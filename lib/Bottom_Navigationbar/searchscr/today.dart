import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Todaydate extends StatefulWidget {
  const Todaydate({super.key});

  @override
  State<Todaydate> createState() => _TodaydateState();
}

class _TodaydateState extends State<Todaydate> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.blue,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context); // Close the screen
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "When are you going?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF024550),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Weekday Labels
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sun", style: TextStyle(color: Color(0xFF024550))),
                Text("Mon", style: TextStyle(color: Color(0xFF024550))),
                Text("Tue", style: TextStyle(color: Color(0xFF024550))),
                Text("Wed", style: TextStyle(color: Color(0xFF024550))),
                Text("Thu", style: TextStyle(color: Color(0xFF024550))),
                Text("Fri", style: TextStyle(color: Color(0xFF024550))),
                Text("Sat", style: TextStyle(color: Color(0xFF024550))),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Vertical List of 12 Months
          Expanded(
            child: ListView.builder(
              itemCount: 12, // Display 12 months
              itemBuilder: (context, index) {
                DateTime firstDayOfMonth =
                    DateTime(DateTime.now().year, index + 1, 1);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Month Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          DateFormat.yMMMM().format(firstDayOfMonth),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF024550),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // TableCalendar for Each Month
                      TableCalendar(
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2100),
                        focusedDay: firstDayOfMonth,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        calendarFormat: CalendarFormat.month,
                        headerVisible: false,
                        daysOfWeekVisible: false,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });

                          // Send the selected date back
                          Navigator.pop(context, selectedDay);
                        },
                        calendarStyle: const CalendarStyle(
                          defaultTextStyle: TextStyle(
                            color: Color(0xFF024550),
                          ),
                          todayDecoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Color(0xFF024550),
                            shape: BoxShape.circle,
                          ),
                          outsideDaysVisible: false,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
