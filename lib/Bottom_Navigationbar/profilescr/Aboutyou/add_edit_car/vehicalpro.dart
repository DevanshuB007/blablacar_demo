// // import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
// // import 'package:flutter/material.dart';
// // import 'package:appwrite/appwrite.dart';

// // class VehicleProvider extends ChangeNotifier {
// //   String _selectedBrand = '';
// //   String? _selectedModel;
// //   String? _selectedColor;

// //   String? get selectedBrand => _selectedBrand;
// //   String? get selectedModel => _selectedModel;
// //   String? get selectedColor => _selectedColor;
// //   // Setters

// //   void setCompany(String value) {
// //     _selectedBrand = value;
// //     notifyListeners();
// //   }

// //   void setModel(String value) {
// //     _selectedModel = value;
// //     notifyListeners();
// //   }

// //   void setColor(String value) {
// //     _selectedColor = value;
// //     notifyListeners();
// //   }

// //   // Appwrite setup
// //   final Client client = Client()
// //     ..setEndpoint(AuthConfig.projectId) // Change your Appwrite endpoint
// //     ..setProject(AuthConfig.projectId); // Replace with your Appwrite project ID

// //   final Databases databases = Databases(Client());

// //   Future<void> saveVehicleData() async {
// //     try {
// //       await databases.createDocument(
// //         databaseId: AuthConfig.databaseId, // Replace with your database ID
// //         collectionId:
// //             AuthConfig.collectionId, // Replace with your collection ID
// //         documentId: 'unique()', // Auto-generate ID
// //         data: {
// //           'company': _selectedBrand,
// //           'model': _selectedModel,
// //           'color': _selectedColor,
// //         },
// //       );
// //       print("Vehicle data saved successfully!");
// //     } catch (e) {
// //       print("Error saving vehicle data: $e");
// //     }
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:appwrite/appwrite.dart';
// import 'package:blablacar/appwrite/app/data/config/auth_config.dart';

// class VehicleProvider extends ChangeNotifier {
//   String? _selectedBrand;
//   String? _selectedModel;
//   String? _selectedColor;

//   String? get selectedBrand => _selectedBrand;
//   String? get selectedModel => _selectedModel;
//   String? get selectedColor => _selectedColor;

//   // Setters with debug print
//   void setCompany(String value) {
//     _selectedBrand = value;
//     print(" Brand Set: $_selectedBrand");
//     notifyListeners();
//   }

//   void setModel(String value) {
//     _selectedModel = value;
//     print(" Model Set: $_selectedModel");
//     notifyListeners();
//   }

//   void setColor(String value) {
//     _selectedColor = value;
//     print(" Color Set: $_selectedColor");
//     notifyListeners();
//   }

//   // Appwrite setup
//   final Client client = Client()
//     ..setEndpoint(AuthConfig.projectId) // Appwrite endpoint
//     ..setProject(AuthConfig.projectId); // Project ID

//   final Databases databases = Databases(Client());

//   Future<void> saveVehicleData() async {
//     print(
//         " Saving: Brand=$_selectedBrand, Model=$_selectedModel, Color=$_selectedColor");

//     if (_selectedBrand == null ||
//         _selectedModel == null ||
//         _selectedColor == null) {
//       print(
//           " Error: Missing data - Brand: $_selectedBrand, Model: $_selectedModel, Color: $_selectedColor");
//       return;
//     }

//     try {
//       await databases.createDocument(
//         databaseId: AuthConfig.databaseId,
//         collectionId: AuthConfig.collectionId,
//         documentId: 'unique()',
//         data: {
//           'company': _selectedBrand,
//           'model': _selectedModel,
//           'color': _selectedColor,
//         },
//       );
//       print(" Vehicle data saved successfully!");
//     } catch (e) {
//       print(" Error saving vehicle data: $e");
//     }
//   }
// }

import 'package:blablacar/Bottom_Navigationbar/profilescr/Aboutyou/Aboutyou.dart';
import 'package:blablacar/Bottom_Navigationbar/profilescr/profile_scr.dart';
import 'package:blablacar/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:blablacar/appwrite/app/data/config/auth_config.dart';

class VehicleProvider extends ChangeNotifier {
  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedColor;
  String? selectedCarId; // Stores the selected car ID

  String? get selectedBrand => _selectedBrand;
  String? get selectedModel => _selectedModel;
  String? get selectedColor => _selectedColor;

  final Client client = Client()
    ..setEndpoint(AuthConfig.endpoint) // Replace with your endpoint
    ..setProject(AuthConfig.projectId) // Replace with your project ID
    ..setSelfSigned(status: true);

  late final Databases databases;
  late final Account account;

  VehicleProvider() {
    databases = Databases(client);
    account = Account(client);
  }

  // 🆔 Fetch logged-in user ID
  Future<String?> getUserId() async {
    try {
      final session = await account.get();
      return session.$id;
    } catch (e) {
      debugPrint(" Error fetching user ID: $e");
      return null;
    }
  }

  //  Setters for selected vehicle data
  void setCompany(String value) {
    _selectedBrand = value;
    notifyListeners();
  }

  void setModel(String value) {
    _selectedModel = value;
    notifyListeners();
  }

  void setColor(String value) {
    _selectedColor = value;
    notifyListeners();
  }

  void setSelectedCarId(String? carId) {
    selectedCarId = carId;
    notifyListeners();
  }

  //  Save new vehicle data to Appwrite
  Future<void> saveVehicleData() async {
    String? userId = await getUserId(); // Fetch user ID

    if (userId == null) {
      debugPrint(" Error: User not logged in.");
      return;
    }

    if (_selectedBrand == null ||
        _selectedModel == null ||
        _selectedColor == null) {
      debugPrint(
          " Error: Missing data - Brand: $_selectedBrand, Model: $_selectedModel, Color: $_selectedColor");
      return;
    }

    try {
      await databases.createDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.vehicalcollectionId,
        documentId: ID.unique(),
        data: {
          'users': [userId],
          'brand_name': _selectedBrand,
          'model_name': _selectedModel,
          'color_name': _selectedColor,
        },
      );

      debugPrint(" Vehicle data saved successfully!");
    } catch (e) {
      debugPrint(" Error saving vehicle data: $e");
    }
  }

  // ✏️ Update existing vehicle data
  Future<void> updateVehicleData() async {
    if (selectedCarId == null) {
      debugPrint(" Error: No vehicle selected.");
      return;
    }

    try {
      await databases.updateDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.vehicalcollectionId,
        documentId: selectedCarId!,
        data: {
          'brand_name': _selectedBrand,
          'model_name': _selectedModel,
          'color_name': _selectedColor,
        },
      );

      debugPrint(" Vehicle updated successfully!");
      notifyListeners();
    } catch (e) {
      debugPrint(" Error updating vehicle: $e");
    }
  }

  Future<void> deleteVehicle(BuildContext context, String? carId) async {
    if (carId == null || carId.isEmpty) {
      debugPrint(" No car ID provided for deletion!");
      return;
    }

    try {
      await databases.deleteDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.vehicalcollectionId,
        documentId: carId,
      );

      // notifyListeners();
      debugPrint(" Vehicle deleted successfully!");

      //  Navigate to Home Screen after deletion
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ProfileScr()),
        (route) => false,
      );
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const Aboutyou(),
      //     ));
    } catch (e) {
      debugPrint(" Error deleting vehicle: $e");
    }
  }

  // Get Single Car Details
  Future<Map<String, dynamic>> getCarDetails(String carId) async {
    try {
      final response = await databases.getDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.vehicalcollectionId,
        documentId: carId,
      );

      _selectedBrand = response.data['brand_name'];
      _selectedModel = response.data['model_name'];
      _selectedColor = response.data['color_name'];

      return response.data;
    } catch (e) {
      print(" Error fetching car details: $e");
      return {};
    }
  }

// Update Car Details
  Future<void> updateCarData({
    required String carId,
    required String brand,
    required String model,
    required String color,
  }) async {
    try {
      await databases.updateDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.vehicalcollectionId,
        documentId: carId,
        data: {
          'brand_name': brand,
          'model_name': model,
          'color_name': color,
        },
      );
      print(" Vehicle updated successfully!");
    } catch (e) {
      print(" Error updating vehicle: $e");
    }
  }

  Future<void> updateCarDetails({
    required String carId,
    required String brand,
    required String color,
  }) async {
    try {
      // Update Data in Appwrite DB
      await databases.updateDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.vehicalcollectionId,
        documentId: carId,
        data: {
          'model_name': _selectedModel,
          'brand_name': brand,
          'color': color,
        },
      );
      _selectedBrand = brand;
      _selectedColor = color;
      notifyListeners();
    } catch (e) {
      print('Error updating car details: $e');
    }
  }

  Future<void> fetchCarById(String carId) async {
    try {
      final response = await databases.getDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.vehicalcollectionId,
        documentId: carId,
      );
      selectedCarId = response.data['id'] as String?;
      notifyListeners();
    } catch (e) {
      print('Error fetching car: $e');
    }
  }

  Future<void> updateVehicle({
    required String carId,
    required String brand,
    required String model,
    required String color,
  }) async {
    try {
      await databases.updateDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.vehicalcollectionId,
        documentId: carId,
        data: {
          'brand_name': brand,
          'model_name': model,
          'color_name': color,
        },
      );
      print('Vehicle Updated');
    } catch (e) {
      print('Error updating vehicle: $e');
    }
  }
}
