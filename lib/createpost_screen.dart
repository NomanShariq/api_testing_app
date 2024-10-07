import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'Create Post',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 200),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post Title Field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Post Title:",
                      hintText: "Enter Your Title",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // Post Content Field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Post Content:",
                      hintText: "Enter Your Content",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // Post Image Picker
                  Row(
                    children: [
                      const Text("Post Image:"),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle file selection logic here
                        },
                        child: const Text("Choose File"),
                      ),
                      const SizedBox(width: 10),
                      const Text("No File Chosen"), // Placeholder text
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  // Create Post Button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 48, 48, 48), // Button color
                        minimumSize: const Size(350, 50),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Handle form submission logic here
                        }
                      },
                      child: const Text(
                        "Create Post",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
