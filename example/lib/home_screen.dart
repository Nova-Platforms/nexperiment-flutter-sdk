import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nexperiment/nexperiment.dart';

class HomeScreen extends StatefulWidget {
  final Nexperiment nexperimentSDK;

  const HomeScreen({super.key, required this.nexperimentSDK});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late Nexperiment _nexperimentSDK;
  bool showNewExperience = true;
  Random random = Random();

  @override
  void initState() {
    _nexperimentSDK = widget.nexperimentSDK;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _nexperimentSDK.getToggle("new-home-layout").then((toggle) => toggle.value),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          showNewExperience = snapshot.data!;

          if (showNewExperience)
            return NewHomeBankScreen();
          else
            return HomeBankScreen();
        }
      },
    );
  }
}

class HomeBankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Account Balance',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balance',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$10,000.00',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Assuming there are 5 recent transactions
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.money),
                    title: Text('Transaction ${index + 1}'),
                    subtitle: const Text('\$100.00'),
                    trailing: const Text('Yesterday'), // Assuming all transactions were yesterday
                    onTap: () {
                      // Handle tap on transaction
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating action button press (e.g., add transaction)
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NewHomeBankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carlos Augusto Alves'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings icon press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'New Account Balance',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balance',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$10,000.00',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Assuming there are 5 recent transactions
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction ${index + 1}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              '\$100.00',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              'Location: Grocery Store',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              'Date Time: Yesterday',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Exclusive Investment Options'),
                    onTap: () {
                      // Handle tap on exclusive feature
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Personal Financial Advisor'),
                    onTap: () {
                      // Handle tap on exclusive feature
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Priority Customer Support'),
                    onTap: () {
                      // Handle tap on exclusive feature
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating action button press (e.g., add transaction)
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
