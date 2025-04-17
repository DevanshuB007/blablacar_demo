import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/edit%20travel%20pref/chattiness.dart'
    as chattiness_pref;
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/edit%20travel%20pref/music.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/edit%20travel%20pref/pets.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/edit%20travel%20pref/smoking.dart';
import 'package:blablacar/appwrite/app/data/provider/radio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Edittravelpref extends StatefulWidget {
  const Edittravelpref({super.key});

  @override
  State<Edittravelpref> createState() => _EdittravelprefState();
}

class _EdittravelprefState extends State<Edittravelpref> {
  String _selectedChattiness = "I love to chat"; // Default value
  String _selectedMusic = "I'll am depending on the mood"; // Default value
  String _selectedSmoking = "No smoking, please"; // Default value
  String _selectedPetOption =
      "I'll travel with pets depending on the animal"; // Default value

  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<RadioProvider>(context);

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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Travel Preferences',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                'Chattiness',
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              subtitle: Text(
                radioProvider.selectedOption ?? 'I love to chat',
                // 'i love to chat',
                style: TextStyle(
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const chattiness_pref.Chattiness()),
                );
                if (result != null) {
                  setState(() {
                    _selectedChattiness = result;
                  });
                }
              },
            ),
            ListTile(
              title: Text(
                'Music',
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              subtitle: Text(
                radioProvider.selectedMusic ?? "i'll am depending on the mood",
                // "i'll am depending on the mood",
                style: TextStyle(
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Music()),
                );

                if (result != null) {
                  setState(() {
                    _selectedMusic = result;
                  });
                }
              },
            ),
            ListTile(
              title: Text(
                'Smoking',
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              subtitle: Text(
                _selectedSmoking,
                // 'Cigarette breaks outside the car aree okk',
                style: TextStyle(
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Smoking()),
                );

                if (result != null) {
                  setState(() {
                    _selectedSmoking = result;
                  });
                }
              },
            ),
            ListTile(
              title: Text(
                'Pets',
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              subtitle: Text(
                _selectedPetOption,
                // "i'll travle with pets depending onn the animal",
                style: TextStyle(
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pets()),
                );

                if (result != null) {
                  setState(() {
                    _selectedPetOption = result;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
