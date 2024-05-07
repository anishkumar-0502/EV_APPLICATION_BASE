import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/pages/Auth/login.dart';
import 'src/pages/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData customTheme = ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );

    return MaterialApp(
      title: 'EV',
      debugShowCheckedModeBanner: false,
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

  const SessionHandler({Key? key, this.loggedIn = false}) : super(key: key);

  @override
  State<SessionHandler> createState() => _SessionHandlerState();
}

class _SessionHandlerState extends State<SessionHandler> {
  String? storedUser;

  @override
  void initState() {
    super.initState();
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
        ? HomePage(userinfo: storedUser)
        : const LoginPage(title: 'Login');
  }
}
