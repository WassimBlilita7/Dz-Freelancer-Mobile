import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/profile/controllers/profile_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/profile/providers/profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileController controller;
  final String token;

  const EditProfileScreen({
    Key? key,
    required this.controller,
    required this.token,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    widget.controller.fetchProfile(context, widget.token); // Charger le profil dès que l'écran s'ouvre
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await widget.controller.updateProfilePicture(context, widget.token, File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier Profil'),
      ),
      body: provider.model.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60.r,
                  backgroundImage: provider.model.profilePicture != null
                      ? NetworkImage(provider.model.profilePicture!)
                      : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              _buildTextField(
                label: 'Prénom',
                initialValue: provider.model.firstName,
                onChanged: (value) => provider.updateField(firstName: value),
              ),
              SizedBox(height: 10.h),
              _buildTextField(
                label: 'Nom',
                initialValue: provider.model.lastName,
                onChanged: (value) => provider.updateField(lastName: value),
              ),
              SizedBox(height: 10.h),
              _buildTextField(
                label: 'Bio',
                initialValue: provider.model.bio,
                onChanged: (value) => provider.updateField(bio: value),
                maxLines: 3,
              ),
              SizedBox(height: 10.h),
              _buildTextField(
                label: 'Nom de l\'entreprise',
                initialValue: provider.model.companyName,
                onChanged: (value) => provider.updateField(companyName: value),
              ),
              SizedBox(height: 10.h),
              _buildTextField(
                label: 'Site Web',
                initialValue: provider.model.webSite,
                onChanged: (value) => provider.updateField(webSite: value),
              ),
              SizedBox(height: 30.h),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await widget.controller.updateProfile(context, widget.token);
                  }
                },
                child: const Text('Sauvegarder'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required Function(String) onChanged,
    int maxLines = 1,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) => (value == null || value.isEmpty) ? 'Champ requis' : null,
    );
  }
}
