import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/elevationbutton.dart';
import '../Wallet/wallet.dart';
import '../History/history.dart';
import './help/help.dart';
import './settings/settings.dart';
import '../Auth/login.dart';
import '../../utilities/User_Model/user.dart'; // Import the UserData model
import 'package:provider/provider.dart';

class profilepage extends StatefulWidget {
  final String? username; // Make the username parameter nullable
  const profilepage({super.key, this.username});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  String activeTab = 'profile'; // Initial active tab

  void setActiveTab(String newTab) {
    // Define the callback
    setState(() {
      activeTab = newTab;
    });
  }

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user'); // Remove the user data from shared preferences

    // Clear user data from the provider
    Provider.of<UserData>(context, listen: false).clearUser();

    // Navigate to the login page and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(title: 'LoginPage'),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    String? username = widget.username;

    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Icon(
              Icons.account_circle_rounded,
              size: 120,
            ),
            Text(
              username ??
                  '', // Use username parameter, or an empty string if null
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalletPage(
                                  username: username,
                                )),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                                0.2), // Color and transparency of the shadow
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 5, // How blurry the shadow is
                            offset: const Offset(
                                0, 2), // Offset for the shadow (x, y)
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.wallet_outlined,
                            size: 43,
                          ),
                          Text(
                            'Wallet',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => historypage(
                                  username: username,
                                )),
                      );
                    },
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.all(
                          15), // Add padding to each container
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                                0.2), // Color and transparency of the shadow
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 5, // How blurry the shadow is
                            offset: const Offset(
                                0, 2), // Offset for the shadow (x, y)
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.history,
                            size: 43,
                          ),
                          Text(
                            'History',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 18, right: 18),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileSettingPage()),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.all(16), // Padding inside the container
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.2), // Color and transparency of the shadow
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 5, // How blurry the shadow is
                        offset:
                            const Offset(0, 2), // Offset for the shadow (x, y)
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.settings,
                        size: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Settings',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 18, right: 18),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpPage()),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.all(16), // Padding inside the container
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.2), // Color and transparency of the shadow
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 5, // How blurry the shadow is
                        offset:
                            const Offset(0, 2), // Offset for the shadow (x, y)
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Help',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 18, right: 18),
              child: GestureDetector(
                onTap: () {
                  _logout(context); // Call _logout method on tap
                },
                child: Container(
                  padding:
                      const EdgeInsets.all(16), // Padding inside the container
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.2), // Color and transparency of the shadow
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 5, // How blurry the shadow is
                        offset:
                            const Offset(0, 2), // Offset for the shadow (x, y)
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 30,
                        color: Colors.red,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Logout',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingButton(
        activeTab: activeTab,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
