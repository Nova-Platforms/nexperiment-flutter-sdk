import 'package:flutter/material.dart';
import 'package:nexperiment/nexperiment.dart';

class ContextScreen extends StatefulWidget {
  final Nexperiment nexperimentSDK;

  const ContextScreen({super.key, required this.nexperimentSDK});

  @override
  _ContextScreenState createState() => _ContextScreenState();
}

class _ContextScreenState extends State<ContextScreen> {
  late Nexperiment _nexperimentSDK;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nexperimentSDK = widget.nexperimentSDK;

    _emailController.text = _nexperimentSDK.context.containsKey("email") ? _nexperimentSDK.context["email"] : '';
    _countryController.text = _nexperimentSDK.context.containsKey("country") ? _nexperimentSDK.context["country"] : '';
    _stateController.text = _nexperimentSDK.context.containsKey("state") ? _nexperimentSDK.context["state"] : '';
    _ageController.text = _nexperimentSDK.context.containsKey("age") ? _nexperimentSDK.context["age"] : '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'User Data',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  prefixIcon: Icon(Icons.money),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: 'State',
                  prefixIcon: Icon(Icons.location_city),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  final String email = _emailController.text;
                  final String state = _stateController.text;
                  final String country = _countryController.text;
                  final String age = _ageController.text;

                  try {
                    widget.nexperimentSDK.setContext({
                      'email': email,
                      'country': country,
                      'state': state,
                      'age': age,
                    });

                    showAlertDialog(context);
                  } catch (e) {
                    print('Error: $e');
                  }
                },
                child: const Text(
                  'SAVE',
                  style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ));
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: const Text("Success"),
      content: const Text("Context saved successfully!"),
      actions: [
        TextButton(
          child: const Text("OK"),
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
