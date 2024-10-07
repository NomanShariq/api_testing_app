import 'package:check_api/createpost_screen.dart';
import 'package:check_api/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Image.asset(
            "images/logo.png",
            fit: BoxFit.fill,
            height: 50,
            width: 200,
          ).centered(),
        ),
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(Icons.more_vert, size: 26.0),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreatePostScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: const PostsList(),
    );
  }

  // Function to show logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                // Perform your logout logic here
                // For example, clear user session or navigate to login screen
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to login screen or perform logout
                Navigator.pushNamed(context, "/login");
              },
            ),
          ],
        );
      },
    );
  }
}
