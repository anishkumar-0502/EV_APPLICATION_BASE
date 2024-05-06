import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/elevationbutton.dart';

class sessiondetailspage extends StatefulWidget {
  const sessiondetailspage({super.key});

  @override
  State<sessiondetailspage> createState() => _sessiondetailspageState();
}

class _sessiondetailspageState extends State<sessiondetailspage> {
  String activeTab = 'history'; // Initial active tab

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
        title: const Text('Session Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/Image/CC.jpg',
                height: 320,
              ),
              Container(
                margin: const EdgeInsets.only(
                    bottom: 20), // Add margin at the bottom of the container
                width: 320,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Charger ID', '390606004655'),
                    _buildDetailRow('Charger Session ID', '2918694'),
                    _buildDetailRow('Start Time', '5/3/2024, 2:58:51 PM'),
                    _buildDetailRow('Stop Time', '5/3/2024, 2:58:51 PM'),
                    _buildDetailRow('Unit Consumed', '0.000'),
                    _buildDetailRow('Price', 'RS.0.00'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButton(
        activeTab: activeTab,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8), // Add vertical spacing between rows
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        const SizedBox(
            height: 4), // Add vertical spacing between title and value
        Text(
          value,
          style: const TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}
