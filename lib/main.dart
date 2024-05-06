import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/pages/Auth/login.dart';
import 'src/pages/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your custom theme
    final ThemeData customTheme = ThemeData(
      // Define the input field theme
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      // Add more customizations as needed
    );

    return MaterialApp(
      title: 'EV',
      debugShowCheckedModeBanner: false,
      // Apply your custom theme
      theme: customTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SessionHandler(),
        '/home': (context) => const SessionHandler(loggedIn: true),
      },
    );
  }
}

class SessionHandler extends StatefulWidget {
  final bool loggedIn;
  final String? userinfo; // Add userinfo parameter

  const SessionHandler({super.key, this.loggedIn = false, this.userinfo});

  @override
  State<SessionHandler> createState() => _SessionHandlerState();
}

class _SessionHandlerState extends State<SessionHandler> {
  String? storedUser;

  @override
  void initState() {
    super.initState();
    // Retrieve user data from shared preferences when the app starts
    _retrieveUserData();
  }

  Future<void> _retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedUser = prefs.getString('user');
    });
  }

  @override
  Widget build(BuildContext context) {
    return storedUser != null
        ? const HomePage() 
        : const LoginPage(title: 'Login');
  }
}
