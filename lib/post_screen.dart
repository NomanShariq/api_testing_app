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
      Uri.parse('https://express-ts-rest-api.onrender.com/api/v1/posts'),
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
              // final updatedAt = post['updatedAt'] ?? 'No Date';

              // Parse and format the dates
              DateTime createdDateTime = DateTime.parse(createdAt);
              // DateTime updatedDateTime = DateTime.parse(updatedAt);
              String formattedCreatedAt = DateFormat('d MMMM y, HH:mm')
                  .format(createdDateTime); // e.g., 31 August 2024, 12:11
              // String formattedUpdatedAt = DateFormat('d MMMM y, HH:mm')
              //     .format(updatedDateTime); // e.g., 31 August 2024, 12:35

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
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 26.0),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.green,
                                onPressed: () {},
                              ),
                              const SizedBox(width: 16.0),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                      subtitle: Text(summary),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 17.0),
                      child: Text(formattedCreatedAt),
                      // Text('Updated At: $formattedUpdatedAt'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        "images/mountains.png",
                        fit: BoxFit.fill,
                        height: 300,
                        width: 500,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 16, bottom: 15),
                      child: Text("From: Noman"),
                      // Text('Updated At: $formattedUpdatedAt'),
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
