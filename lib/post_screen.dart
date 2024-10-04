import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
              // final id = post['id'] ?? 'No ID';
              // final title = post['title'] ?? 'No Title';
              final summary = post['summary'] ?? 'No Summary';
              // final coverImage = post['coverImage'] ?? '';
              final createdAt = post['createdAt'] ?? 'No Date';
              final updatedAt = post['updatedAt'] ?? 'No Date';
              return Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "images/mountains.png",
                      fit: BoxFit.fill,
                      height: 300,
                      width: 500,
                    ),
                    ListTile(
                      // title: Text('ID: $id\n$title'),
                      subtitle: Text(summary),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Created At: $createdAt\nUpdated At: $updatedAt'),
                    ),
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
