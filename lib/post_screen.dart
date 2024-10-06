import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart'; // Add this import

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  Future<List<dynamic>> fetchPosts() async {
    print('Fetching posts...');
    final response = await http.get(
      Uri.parse('Your Api Key'),
    );

    if (response.statusCode == 200) {
      print('Successfully fetched posts');
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print('API Response: $jsonResponse');
      return jsonResponse['data']['posts'] ?? [];
    } else {
      print('Failed to fetch posts: ${response.statusCode}');
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        print('Snapshot state: ${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final posts = snapshot.data!;
          if (posts.isEmpty) {
            return const Center(child: Text('No posts available'));
          }
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final title = post['title'] ?? 'No Title';
              final summary = post['summary'] ?? 'No Summary';
              final createdAt = post['createdAt'] ?? 'No Date';

              // Parse and format the dates
              DateTime createdDateTime = DateTime.parse(createdAt);
              String formattedCreatedAt = DateFormat('d MMMM y, HH:mm')
                  .format(createdDateTime); // e.g., 31 August 2024, 12:11

              return Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 10)),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.green,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              showDeleteConfirmationDialog(context, () {
                                // Your delete logic here
                                print("Item deleted");
                              });
                            },
                          ),
                        ],
                      ),
                      subtitle: Text(summary),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 17.0),
                      child: Text(formattedCreatedAt),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        "images/mountains.jpg",
                        fit: BoxFit.fill,
                        height: 300,
                        width: 500,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 16, bottom: 15),
                      child: Text("From: Noman"),
                    ).objectCenterRight(),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}

void showDeleteConfirmationDialog(
    BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Confirmation"),
        content: const Text("Are you sure you want to delete this item?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          ElevatedButton(
            child: const Text("Delete"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              onConfirm(); // Perform the delete action
            },
          ),
        ],
      );
    },
  );
}
