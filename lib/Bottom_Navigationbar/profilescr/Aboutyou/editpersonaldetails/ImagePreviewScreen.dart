// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePreviewScreen extends StatefulWidget {
//   const ImagePreviewScreen({super.key});

//   @override
//   State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
// }

// class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
//   File? _selectedImage;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.blue),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Center(
//                 child: _selectedImage != null
//                     ? Image.file(_selectedImage!)
//                     : Text(
//                         "No Image Selected",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: _pickImage,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 child: Text("Choose Image", style: TextStyle(color: Colors.white)),
//               ),
//             ),
//             if (_selectedImage != null)
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 16.0),
//                 child: ElevatedButton(
//                   onPressed: () {}, // Implement save functionality
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: Text("Save", style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
