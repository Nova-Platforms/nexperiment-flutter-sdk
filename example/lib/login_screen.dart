import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nexperiment/nexperiment.dart';

class LoginScreen extends StatefulWidget {
  final Nexperiment nexperimentSDK;

  const LoginScreen({super.key, required this.nexperimentSDK});

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  late Nexperiment _nexperimentSDK;
  bool enableShowSocialLogin = true;
  Random random = Random();

  @override
  void initState() {
    _nexperimentSDK = widget.nexperimentSDK;

    _nexperimentSDK.getToggle("enable-social-media-login").then((toggle) {
      enableShowSocialLogin = toggle.value;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _nexperimentSDK.getToggle("enable-social-media-login").then((toggle) => toggle.value),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the result, show a loading indicator or placeholder
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Handle error case
          return Text('Error: ${snapshot.error}');
        } else {
          // Once the result is available, update the value of enableFacebooklogin
          enableShowSocialLogin = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (enableShowSocialLogin)
                      ElevatedButton(
                        onPressed: () {
                          int randomNumber = random.nextInt(100) + 1;
                          if (randomNumber <= 50) {
                            showAlertDialog(context);
                          }
                        },
                        child: SizedBox(height: 40, child: Image.asset('assets/images/google+.png')),
                      ),
                    if (enableShowSocialLogin)
                      ElevatedButton(
                        onPressed: () {
                          int randomNumber = random.nextInt(100) + 1;
                          if (randomNumber <= 50) {
                            showAlertDialog(context);
                          }
                        },
                        child: SizedBox(height: 40, child: Image.asset('assets/images/facebook.png')),
                      ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: const Text("Notice"),
      content: const Text(
          "An error occurred when trying to initialize the Facebook or Google SDK. Try to use the system login."),
      actions: [
        TextButton(
          child: const Text("Got it"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
