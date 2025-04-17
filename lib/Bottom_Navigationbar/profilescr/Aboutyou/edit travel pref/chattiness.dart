import 'package:flutter/material.dart';

// class Chattiness extends StatefulWidget {
//   const Chattiness({super.key});

//   @override
//   State<Chattiness> createState() => _ChattinessState();
// }

// class _ChattinessState extends State<Chattiness> {
//   String? _selectedOption; // Tracks the selected custom radio button
//   bool _isSaving = false; // To show loader on save button click

//   Future<void> _saveOption() async {
//     setState(() {
//       _isSaving = true; // Show loader
//     });

//     // Simulate saving process
//     await Future.delayed(const Duration(seconds: 2));

//     setState(() {
//       _isSaving = false; // Hide loader
//     });

//     // Close screen and return selected value
//     Navigator.pop(context, _selectedOption);
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
//           _selectedOption = value;
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
//               child: _selectedOption == value
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
//               'Chattiness',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Use the custom method to build each radio button
//             buildCustomRadioButton(
//               icon: Icons.chat_bubble_outline,
//               label: "I love to chat",
//               value: "I love to chat",
//             ),
//             buildCustomRadioButton(
//               icon: Icons.message_outlined,
//               label: "I'm chatty when I feel comfor-table",
//               value: "I'm chatty when I feel comfor-table",
//             ),
//             buildCustomRadioButton(
//               icon: Icons.chat_bubble,
//               label: "I'm the quiet type",
//               value: "I'm the quiet type",
//             ),
//             const Spacer(),
//             // Save Button
//             Center(
//               child: _selectedOption != null
//                   ? ElevatedButton(
//                       onPressed: _isSaving ? null : _saveOption,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 50,
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

class Chattiness extends StatelessWidget {
  const Chattiness({super.key});

  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<RadioProvider>(context);

    Future<void> _saveOption() async {
      radioProvider.setIsSaving(true); // Show loader

      // Simulate saving process
      await Future.delayed(const Duration(seconds: 2));

      radioProvider.setIsSaving(false); // Hide loader

      // Close screen and return selected value
      Navigator.pop(context, radioProvider.selectedOption);
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
              'Chattiness',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            // Use the custom method to build each radio button
            _buildCustomRadioButton(
              context,
              icon: Icons.chat_bubble_outline,
              label: "I love to chat",
              value: "I love to chat",
            ),
            _buildCustomRadioButton(
              context,
              icon: Icons.message_outlined,
              label: "I'm chatty when I feel comfor-table",
              value: "I'm chatty when I feel comfor-table",
            ),
            _buildCustomRadioButton(
              context,
              icon: Icons.chat_bubble,
              label: "I'm the quiet type",
              value: "I'm the quiet type",
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
        radioProvider.setSelectedOption(value);
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
              child: radioProvider.selectedOption == value
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
