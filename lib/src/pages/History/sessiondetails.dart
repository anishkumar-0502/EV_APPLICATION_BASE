import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../components/elevationbutton.dart';
import 'package:intl/intl.dart';

class sessiondetailspage extends StatefulWidget {
  final String? username; // Make the username parameter nullable
  final Map<String, dynamic> sessionData;
  const sessiondetailspage({Key? key, this.username, required this.sessionData})
      : super(key: key);

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
    String? username = widget.username;
    Map<String, dynamic> sessionData = widget.sessionData;

    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Session Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 50.0), // Adjust the value as needed
                child: Image.asset(
                  'assets/Image/CC.jpg',
                  height: 120,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    bottom: 20,
                    top: 50), // Add margin at the bottom of the container
                width: 320,
                padding: const EdgeInsets.all(16.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                        'Charger ID', sessionData['ChargerID'].toString()),
                    _buildDetailRow('Charger Session ID',
                        sessionData['ChargingSessionID'].toString()),
                    _buildDetailRow(
                      'Start Time',
                      sessionData['StartTimestamp'] != null
                          ? DateFormat('MM/dd/yyyy, hh:mm:ss a').format(
                              DateTime.parse(sessionData['StartTimestamp'])
                                  .toLocal(),
                            )
                          : "-",
                    ),
                    _buildDetailRow(
                      'Stop Time',
                      sessionData['StopTimestamp'] != null
                          ? DateFormat('MM/dd/yyyy, hh:mm:ss a').format(
                              DateTime.parse(sessionData['StopTimestamp'])
                                  .toLocal(),
                            )
                          : "-",
                    ),
                    _buildDetailRow('Unit Consumed',
                        sessionData['Unitconsumed'].toString()),
                    _buildDetailRow('Price', 'Rs. ${sessionData['price']}'),
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
