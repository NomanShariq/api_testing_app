import 'package:check_api/home_screen.dart';
import 'package:check_api/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool _obscureText = true; // Control password visibility

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
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //         ),
      //         child: Text('Drawer Header'),
      //       ),
      //       ListTile(
      //         title: const Text('Item 1'),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         title: const Text('Item 2'),
      //         onTap: () {},
      //       ),
      //     ],
      //   ),
      // ),
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
                    "Login.",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ).objectCenterLeft(),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  const Text(
                    "If you have an account with us, please log in.",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ).objectCenterLeft(),
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                  ),
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
                        // Validate form and navigate to HomeScreen if valid
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
                        "Login",
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
                            "Don’t Have an Account? ",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Sign Up Page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen()));
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 255, 0, 0)),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
