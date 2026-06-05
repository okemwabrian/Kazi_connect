import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme.dart';
import '../../shared/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Uint8List? _webImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _webImage = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          maxWidth: 600,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Center(
                  child: Hero(
                    tag: 'profile_pic',
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: AppTheme.emeraldGreen.withOpacity(0.1),
                          backgroundImage: _webImage != null ? MemoryImage(_webImage!) : null,
                          child: _webImage == null
                              ? const Icon(Icons.person, size: 80, color: AppTheme.emeraldGreen)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.gold,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4),
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
                                ],
                              ),
                              child: const Icon(Icons.camera_alt_rounded, size: 24, color: AppTheme.deepNavy),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                _buildEditField('Full Name', 'Sarah Kamau', Icons.person_outline),
                const SizedBox(height: 24),
                _buildEditField('Email', 'sarah.kamau@example.com', Icons.email_outlined),
                const SizedBox(height: 24),
                _buildEditField('Phone Number', '+254 700 123456', Icons.phone_android_rounded),
                const SizedBox(height: 24),
                _buildEditField('Location', 'Runda, Nairobi', Icons.location_on_outlined),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile updated successfully!'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppTheme.emeraldGreen,
                      ),
                    );
                    context.pop();
                  },
                  child: const Text('Save Changes'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditField(String label, String initialValue, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.deepNavy, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppTheme.deepNavy),
            hintText: 'Enter your $label',
          ),
        ),
      ],
    );
  }
}
