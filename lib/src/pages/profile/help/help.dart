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
        title: const Text('Help', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(222, 255, 255, 255),
                borderRadius: BorderRadius.circular(27.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'NEED HELP? CONTACT US!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'If you require assistance or have any questions, feel free to reach out to us via email or WhatsApp.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      // color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const ContactInfo(
              title: 'Email-Id:',
              info: 'evpower@gmail.com',
              icon: Icons.email,
            ),
            const SizedBox(height: 20),
            const ContactInfo(
              title: 'WhatsApp Number:',
              info: '95959XXXXX',
              icon: Icons.phone,
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                "We're here to help you!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
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

class ContactInfo extends StatelessWidget {
  final String title;
  final String info;
  final IconData icon;

  const ContactInfo({
    Key? key,
    required this.title,
    required this.info,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade700, size: 30),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green.shade700,
                ),
              ),
              Text(
                info,
                style: const TextStyle(
                  fontSize: 17,
                  // color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
