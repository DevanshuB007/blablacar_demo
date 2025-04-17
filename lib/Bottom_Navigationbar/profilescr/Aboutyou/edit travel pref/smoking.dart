// import 'package:flutter/material.dart';

// class Smoking extends StatefulWidget {
//   const Smoking({super.key});

//   @override
//   State<Smoking> createState() => _SmokingState();
// }

// class _SmokingState extends State<Smoking> {
//   String? _selectedSmoking; // Tracks the selected custom radio button
//   bool _isSaving = false; // To show loader on save button click

//   Future<void> _saveSmokingPreference() async {
//     setState(() {
//       _isSaving = true; // Show loader
//     });

//     // Simulate saving process
//     await Future.delayed(const Duration(seconds: 2));

//     setState(() {
//       _isSaving = false; // Hide loader
//     });

//     // Return selected smoking preference
//     Navigator.pop(context, _selectedSmoking);

//     // // Show confirmation message
//     // ScaffoldMessenger.of(context).showSnackBar(
//     //   const SnackBar(
//     //     content: Text('Your Music preference is saved!'),
//     //     duration: Duration(seconds: 2),
//     //   ),
//     // );
//   }

//   // Custom method to create radio button
//   Widget buildCustomRadioButton({
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedSmoking = value;
//         });
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           children: [
//             // Icon
//             Icon(icon, color: Colors.blue, size: 30),
//             const SizedBox(width: 16),
//             // Label
//             Expanded(
//               child: Text(
//                 label,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             // Custom Radio Button
//             Container(
//               height: 24,
//               width: 24,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.blue,
//                   width: 2,
//                 ),
//               ),
//               child: _selectedSmoking == value
//                   ? Center(
//                       child: Container(
//                         height: 12,
//                         width: 12,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     )
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.close,
//             color: Colors.blue,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Smoking',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Use the custom method to build each radio button
//             buildCustomRadioButton(
//               icon: Icons.smoking_rooms_rounded,
//               label: "i'm fine with smoking",
//               value: "i'm fine with smoking",
//             ),
//             buildCustomRadioButton(
//               icon: Icons.smoking_rooms_rounded,
//               label: "Cigarette breaks outside the car are okay",
//               value: "Cigarette breaks outside the car are okay",
//             ),
//             buildCustomRadioButton(
//               icon: Icons.smoke_free_outlined,
//               label: "No smoking, please",
//               value: "No smoking, please",
//             ),
//             const Spacer(),
//             // Save Button
//             Center(
//               child: _selectedSmoking != null
//                   ? ElevatedButton(
//                       onPressed: _isSaving ? null : _saveSmokingPreference,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 30,
//                           vertical: 15,
//                         ),
//                       ),
//                       child: _isSaving
//                           ? const CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 Colors.green,
//                               ),
//                             )
//                           : const Text(
//                               'Save',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                               ),
//                             ),
//                     )
//                   : const SizedBox(),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blablacar/appwrite/app/data/provider/radio_provider.dart';

class Smoking extends StatelessWidget {
  const Smoking({super.key});

  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<RadioProvider>(context);

    Future<void> _saveOption() async {
      radioProvider.setIsSaving(true); // Show loader

      // Simulate saving process
      await Future.delayed(const Duration(seconds: 2));

      radioProvider.setIsSaving(false); // Hide loader

      // Close screen and return selected value
      Navigator.pop(context, radioProvider.selectedSmoking);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Smoking',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            // Use the custom method to build each radio button
            _buildCustomRadioButton(
              context,
              icon: Icons.smoking_rooms_rounded,
              label: "i'm fine with smoking",
              value: "i'm fine with smoking",
            ),
            _buildCustomRadioButton(
              context,
              icon: Icons.smoking_rooms_rounded,
              label: "Cigarette breaks outside the car are okay",
              value: "Cigarette breaks outside the car are okay",
            ),
            _buildCustomRadioButton(
              context,
              icon: Icons.smoke_free_outlined,
              label: "No smoking, please",
              value: "No smoking, please",
            ),

            const Spacer(),

            // Save Button
            Center(
              child: radioProvider.selectedOption != null
                  ? ElevatedButton(
                      onPressed: radioProvider.isSaving ? null : _saveOption,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                      ),
                      child: radioProvider.isSaving
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            )
                          : const Text(
                              'Save',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                    )
                  : const SizedBox(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Custom method to create radio button
  Widget _buildCustomRadioButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final radioProvider = Provider.of<RadioProvider>(context);

    return GestureDetector(
      onTap: () {
        radioProvider.setSelectedSmoking(value);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: radioProvider.selectedSmoking == value
                  ? Center(
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
