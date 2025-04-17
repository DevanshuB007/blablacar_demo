// import 'package:flutter/material.dart';

// class Pets extends StatefulWidget {
//   const Pets({super.key});

//   @override
//   State<Pets> createState() => _PetsState();
// }

// class _PetsState extends State<Pets> {
//   String? _selectedPetOption; // Tracks the selected custom radio button
//   bool _isSaving = false; // To show loader on save button click

//   Future<void> _savePetPreference() async {
//     setState(() {
//       _isSaving = true; // Show loader
//     });

//     // Simulate saving process
//     await Future.delayed(const Duration(seconds: 2));

//     setState(() {
//       _isSaving = false; // Hide loader
//     });

//     // Return selected pet preference
//     Navigator.pop(context, _selectedPetOption);

//     // Show confirmation message
//     // ScaffoldMessenger.of(context).showSnackBar(
//     //   const SnackBar(
//     //     content: Text('Your Pets preference is saved!'),
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
//           _selectedPetOption = label;
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
//               child: _selectedPetOption == value
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
//               'Music',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Use the custom method to build each radio button
//             buildCustomRadioButton(
//               icon: Icons.pets,
//               label: "Pets welcome.woof!",
//               value: "Pets welcome.woof!",
//             ),
//             buildCustomRadioButton(
//               icon: Icons.pets_rounded,
//               label: "i'll travel with pets depending on the animal",
//               value: "i'll travel with pets depending on the animal",
//             ),
//             buildCustomRadioButton(
//               icon: Icons.pets_sharp,
//               label: "i'd prefer not to travel with pets",
//               value: "i'd prefer not to travel with pets",
//             ),
//             const Spacer(),
//             // Save Button
//             Center(
//               child: _selectedPetOption != null
//                   ? ElevatedButton(
//                       onPressed: _isSaving ? null : _savePetPreference,
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

class Pets extends StatelessWidget {
  const Pets({super.key});

  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<RadioProvider>(context);

    Future<void> _saveOption() async {
      radioProvider.setIsSaving(true); // Show loader

      // Simulate saving process
      await Future.delayed(const Duration(seconds: 2));

      radioProvider.setIsSaving(false); // Hide loader

      // Close screen and return selected value
      Navigator.pop(context, radioProvider.selectedPetOption);
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
              'Pets',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            // Use the custom method to build each radio button
            _buildCustomRadioButton(
              context,
              icon: Icons.pets,
              label: "Pets welcome.woof!",
              value: "Pets welcome.woof!",
            ),
            _buildCustomRadioButton(
              context,
              icon: Icons.pets_rounded,
              label: "I'll travel with pets depending on the animal",
              value: "I'll travel with pets depending on the animal",
            ),
            _buildCustomRadioButton(
              context,
              icon: Icons.pets_sharp,
              label: "I'd prefer not to travel with pets",
              value: "I'd prefer not to travel with pets",
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
        radioProvider.setSelectedPetOption(value);
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
              child: radioProvider.selectedPetOption == value
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
