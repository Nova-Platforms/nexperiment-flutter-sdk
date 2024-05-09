import 'package:nexperiment_flutter_example/context_screen.dart';
import 'package:nexperiment_flutter_example/home_screen.dart';
import 'package:nexperiment_flutter_example/login_screen.dart';
import 'package:nexperiment_flutter_example/salary_screen.dart';
import 'package:flutter/material.dart';
import 'package:nexperiment/nexperiment.dart';

void main() {
  runApp(const MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexperiment Demo',
      theme: ThemeData(
        brightness: Brightness.dark, // Force dark mode
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AppScreen(),
    );
  }
}

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _selectedIndex = 0;
  late Nexperiment nexperimentSDK;

  @override
  void initState() {
    super.initState();
    initializeNexperimentSDK();
  }

  Future<void> initializeNexperimentSDK() async {
    nexperimentSDK = Nexperiment();
    await nexperimentSDK.init(
        'http://localhost:3010', '9580f7cd-0133-4f00-ad69-3dcd111a55e7', '0e800f01-2fe9-4c58-9834-79c9dc567ab8');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nexperiment Demo'),
      ),
      body: getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Context',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Home Bank',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Salary',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return ContextScreen(nexperimentSDK: nexperimentSDK);
      case 1:
        return LoginScreen(nexperimentSDK: nexperimentSDK);
      case 2:
        return HomeScreen(nexperimentSDK: nexperimentSDK);
      case 3:
        return SalaryCalculator(nexperimentSDK: nexperimentSDK);
      default:
        return ContextScreen(nexperimentSDK: nexperimentSDK);
    }
  }
}
