import 'package:blablacar/appwrite/app/data/config/auth_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'dart:io';

class Addprofile extends StatefulWidget {
  const Addprofile({super.key});

  @override
  State<Addprofile> createState() => _AddprofileState();
}

class _AddprofileState extends State<Addprofile> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final Client _client = Client()
      .setEndpoint(AuthConfig.endpoint)
      .setProject(AuthConfig.projectId)
      .setSelfSigned(status: true);

  late Storage _storage;
  late Databases _databases;
  late Account _account;
  String? _uploadedImageUrl;
  String? _userId;
  bool _isLoading = false;
  Map<String, dynamic>? userData = {};

  @override
  void initState() {
    super.initState();
    _storage = Storage(_client);
    _databases = Databases(_client);
    _account = Account(_client);
    _fetchUserIdAndPhoto();
  }

  Future<void> _fetchUserIdAndPhoto() async {
    try {
      final user = await _account.get();
      _userId = user.$id;
      await _fetchUserProfilePhoto();
    } catch (e) {
      print(" Failed to fetch user ID: $e");
    }
  }

  Future<void> _takePicture() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    _processSelectedImage(pickedImage);
  }

  Future<void> _chooseFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    _processSelectedImage(pickedImage);
  }

  void _processSelectedImage(XFile? pickedImage) {
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
      _showImagePreview();
    }
  }

  void _showImagePreview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewScreen(
          imageFile: _imageFile!,
          onRetake: () {
            Navigator.pop(context);
          },
          onSave: () {
            _uploadImageToAppwrite();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

 Future<void> _uploadImageToAppwrite() async {
  if (_imageFile == null || _userId == null) return;

  setState(() {
    _isLoading = true;
  });

  try {
    final uploadedFile = await _storage.createFile(
      bucketId: AuthConfig.bucketId,
      fileId: ID.unique(),
      file: InputFile.fromPath(path: _imageFile!.path),
    );

    String fileUrl =
        "https://cloud.appwrite.io/v1/storage/buckets/${AuthConfig.bucketId}/files/${uploadedFile.$id}/view?project=${AuthConfig.projectId}";

    await _saveImageUrlToDatabase(fileUrl);

    // ✅ Update local UI state (userData)
    setState(() {
      _uploadedImageUrl = fileUrl;
      userData?['profileImage'] = fileUrl;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ Profile picture updated")),
    );
  } catch (e) {
    print("Upload failed: $e");
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  Future<void> _saveImageUrlToDatabase(String imageUrl) async {
    if (_userId == null) return;

    try {
      await _databases.updateDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.collectionId,
        documentId: _userId!,
        data: {"profileImage": imageUrl},
      );
    } catch (e) {
      print(" Failed to save image URL: $e");
    }
  }

  Future<void> _fetchUserProfilePhoto() async {
    if (_userId == null) return;
    try {
      final models.Document response = await _databases.getDocument(
        databaseId: AuthConfig.databaseId,
        collectionId: AuthConfig.collectionId,
        documentId: _userId!,
      );
      String? imageUrl = response.data['profileImage'];
      setState(() {
        _uploadedImageUrl = imageUrl ?? '';
      });
    } catch (e) {
      print(" Error fetching profile photo: $e");
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
          icon: Icon(Icons.arrow_back, color: Colors.blue),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼 Profile Picture Display
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey[300],
                    child: ClipOval(
                      child: _uploadedImageUrl != null &&
                              _uploadedImageUrl!.isNotEmpty
                          ? Image.network(
                              _uploadedImageUrl!,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                            )
                          : _imageFile != null
                              ? Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                )
                              : Image.asset(
                                  'assets/images/girl.jpg',
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                ),
                    ),
                  ),
                  if (_isLoading)
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // ℹ️ Instruction Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Don't wear sunglasses, look straight ahead and make sure you're alone.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),

            Spacer(),

            // 📷 Take a Picture Button
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: _takePicture,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    "Take a Picture",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),

            Center(
              child: TextButton(
                onPressed: _chooseFromGallery,
                child: Text(
                  'Choose a Picture',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final File imageFile;
  final VoidCallback onRetake;
  final VoidCallback onSave;

  const ImagePreviewScreen({
    required this.imageFile,
    required this.onRetake,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Preview")),
      body: Column(
        children: [
          Expanded(child: Image.file(imageFile, fit: BoxFit.cover)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: onRetake,
                child: Icon(
                  Icons.replay,
                  color: Colors.blue,
                  size: 30,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, elevation: 0),
              ),
              ElevatedButton(
                onPressed: onSave,
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
