import 'package:clone/Login.dart';
import 'package:clone/chatpage.dart';
import 'package:clone/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({required this.username});

  void showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Profile"),
              onTap: () {
                Navigator.pop(context); // close dialog
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfilePage(username: username),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context); // close dialog
                showLogoutConfirmation(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Confirm Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // cancel
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('loggedInUser');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
                (route) => false,
              );
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $username"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => showProfileDialog(context),
          ),
        ],
      ),
      body: ChatPage(username: username),
    );
  }
}
