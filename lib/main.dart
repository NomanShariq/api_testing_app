import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Posts from API'),
        ),
        body: const PostsList(),
      ),
    );
  }
}

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
      print('API Response: ${jsonResponse}'); // Print the entire response
      return jsonResponse['posts'] ?? []; // Ensure it returns a list
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
        print(
            'Snapshot state: ${snapshot.connectionState}'); // Debug snapshot state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}'); // Debug error state
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
              final id = post['id'] ?? 'No ID';
              final title = post['title'] ?? 'No Title';
              final body = post['body'] ?? 'No Content';
              final createdAt = post['createdAt'] ?? 'No Date';

              // Display the post ID, title, body, and other fields as necessary
              return ListTile(
                title: Text('ID: $id\n$title'),
                subtitle: Text('$body\nCreated At: $createdAt'),
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
