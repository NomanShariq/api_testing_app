import 'package:check_api/home_screen.dart';
import 'package:check_api/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void validate() {
    if (formkey.currentState!.validate()) {
      print("Ok");
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          size: 30,
        ),
        title: Image.asset(
          "images/mountains.png",
          height: 100,
          width: 250,
        ).centered(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                const Text(
                  "My Account",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ).centered(),
                const Padding(padding: EdgeInsets.only(top: 40)),
                const Text(
                  "Login.",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ).objectCenterLeft(),
                const Padding(padding: EdgeInsets.only(top: 20)),
                const Text(
                  "If you have an account with us, please log in.",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ).objectCenterLeft(),
                const Padding(padding: EdgeInsets.only(top: 40)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Enter Email",
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
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "Enter password",
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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(130, 50)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.blueGrey.shade800),
                    ),
                    onPressed: () {
                      /*------- validate----------*/
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: const Text("Sign In"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
