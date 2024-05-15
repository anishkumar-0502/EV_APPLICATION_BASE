import 'package:flutter/material.dart';
import '../../../components/elevationbutton.dart'; // Corrected import path

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key); // Corrected capitalization

  @override
  State<HelpPage> createState() => _HelpPageState(); // Corrected capitalization
}

class _HelpPageState extends State<HelpPage> {
  String activeTab = 'profile';
  // Initial active tab

  void setActiveTab(String newTab) {
    // Define the callback
    setState(() {
      activeTab = newTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: const Text('Help'), // Proper use of 'const'
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, left: 20),
            padding: const EdgeInsets.all(
                17), // Padding for some space around the text
            decoration: BoxDecoration(
              color: Colors.white, // Background color for the container
              borderRadius: BorderRadius.circular(20), // Border radius
              boxShadow: [
                // Shadow definition
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.5), // Shadow color with some transparency
                  spreadRadius: 3, // How much the shadow spreads
                  blurRadius: 7, // Blurring effect
                  offset: const Offset(0, 3), // Shadow offset (x, y)
                ),
              ],
            ), // Added a basic body layout with a message
            child: const Text(
              'NEED HELP? CONTACT US!',
              style: TextStyle(
                fontSize: 25, // Font size
                fontWeight: FontWeight.bold, // Font weight
                color: Colors.green, // Font color
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40, left: 30, right: 20),
            padding: const EdgeInsets.all(
                20), // Padding for some space around the text
            decoration: BoxDecoration(
              color: Colors.white, // Background color for the container
              borderRadius: BorderRadius.circular(20), // Border radius
              boxShadow: [
                // Shadow definition
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.5), // Shadow color with some transparency
                  spreadRadius: 3, // How much the shadow spreads
                  blurRadius: 7, // Blurring effect
                  offset: const Offset(0, 3), // Shadow offset (x, y)
                ),
              ],
            ), //
            child: const Column(
              children: [
                Text(
                  'If you require assistance or have any questions,feel free to reach out to us via email or WhatsApp',
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'Email-Id:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'evpower@gmail.com',
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'WhatsApp Number:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '95959XXXXX',
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "We're here to help you!",
                    style: TextStyle(fontSize: 17),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingButton(
        activeTab: activeTab,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
