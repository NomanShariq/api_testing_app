import 'package:check_api/createpost_screen.dart';
import 'package:check_api/home_screen.dart';
import 'package:check_api/login_screen.dart';
import 'package:check_api/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/login": (context) => const LoginPage(),
        "/home": (context) => const HomeScreen(),
        "/signup": (context) => const SignupScreen(),
        "/createpostscreen": (context) => const CreatePostScreen(),
      },
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
