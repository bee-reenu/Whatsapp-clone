import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  final String username;
  const EditProfilePage({required this.username});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  void loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('${widget.username}_name') ?? '';
    dobController.text = prefs.getString('${widget.username}_dob') ?? '';
    locationController.text =
        prefs.getString('${widget.username}_location') ?? '';
  }

  void saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${widget.username}_name', nameController.text);
    await prefs.setString('${widget.username}_dob', dobController.text);
    await prefs.setString(
        '${widget.username}_location', locationController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile saved!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Phone Number: ${widget.username}"),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: dobController,
              decoration: InputDecoration(labelText: "Date of Birth"),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: "Location"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveProfile,
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
