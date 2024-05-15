import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/pages/Auth/login.dart';
import 'src/pages/Home.dart';
import 'src/pages/Wallet/wallet.dart'; // Import the Wallet page
import 'src/utilities//User_Model//user.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserData(), // Initialize UserData provider
      child: const MyApp(),
    ),
  );
}

class SessionHandler extends StatefulWidget {
  final bool loggedIn;

  const SessionHandler({Key? key, this.loggedIn = false}) : super(key: key);

  @override
  State<SessionHandler> createState() => _SessionHandlerState();
}


class _SessionHandlerState extends State<SessionHandler> {
  double? walletBalance;

  @override
  void initState() {
    super.initState();
    _retrieveUserData();
  }

  // Method to set wallet balance
  void setWalletBalance(double balance) {
    setState(() {
      walletBalance = balance;
    });
  }

  Future<void> _retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUser = prefs.getString('user') ?? '';

    // Access UserData provider and update user data
    Provider.of<UserData>(context, listen: false).updateUserData(storedUser);
  }

  Future<void> _endChargingSession(String chargerID) async {
    // Function to end charging session
    // You can implement your logic here
  }

  // Function to handle search request
void fetchWalletBalance(String username) async {

    try {
      var response = await http.get(Uri.parse(
          'http://122.166.210.142:8052/GetWalletBalance?username=$username'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setWalletBalance(data['balance']);
      } else {
        throw Exception('Failed to load wallet balance');
      }
    } catch (error) {
      print('Error fetching wallet balance: $error');
    }
  }


  Future<void> handleSearchBox(String chargerID) async {
    // Implement your logic here
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return userData.username != null
        ? HomePage(userinfo: userData.username)
        : const LoginPage(title: 'Login');
  }
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
        '/wallet': (context) => WalletPage(fetchWalletBalance: fetchWalletBalance), // Pass fetchWalletBalance function to WalletPage
      },
    );
  }

  void fetchWalletBalance(String p1) {
  }
}

