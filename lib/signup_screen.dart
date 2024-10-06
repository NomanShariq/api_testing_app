import 'package:check_api/home_screen.dart';
import 'package:check_api/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SignupScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _obscureText = true; // For toggling password visibility

  void validate() {
    if (formkey.currentState!.validate()) {
      print("Ok");
    } else {
      print("Error");
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          size: 30,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      "images/logo.png",
                      fit: BoxFit.fill,
                      height: 50,
                      width: 300,
                    ),
                  ).centered(),
                  const Padding(padding: EdgeInsets.only(top: 40)),
                  const Text(
                    "Sign Up.",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ).objectCenterLeft(),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    "Please create your Account Here.",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ).objectCenterLeft(),
                  const Padding(padding: EdgeInsets.only(top: 35)),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Username",
                      hintText: "Enter Username",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("*Required");
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  // Email Input Field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Enter Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),

                  // Password Input Field with Toggle Visibility
                  TextFormField(
                    obscureText: _obscureText, // Control password visibility
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter password",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed:
                            _togglePasswordVisibility, // Toggle visibility
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            WidgetStateProperty.all(const Size(350, 50)),
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Colors.blueGrey.shade800),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)), // Removes the radius
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Validate and navigate to HomeScreen if valid
                        if (formkey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already Have an Account? ",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to Login Page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                      ],
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
