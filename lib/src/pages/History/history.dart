import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../components/elevationbutton.dart';
import 'sessiondetails.dart';

class historypage extends StatefulWidget {
  const historypage({super.key});

  @override
  State<historypage> createState() => _historypageState();
}

class _historypageState extends State<historypage> {
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
        title: const Text('History'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 25),
              child: Container(
                child: const Row(
                  children: [
                    Text(
                      'Session History',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Icon(
                      Icons.history,
                      color: Colors.black54,
                      size: 33,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 80),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
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
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Scrollbar(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const sessiondetailspage(), // Ensure this is the correct page
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '390606004301',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5), // Add vertical spacing between the two Text widgets
                                    Text(
                                      '4/25/2024, 12:12:54 AM',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '- Rs. 0.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),

                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const sessiondetailspage(), // Ensure this is the correct page
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '390606004301',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5), // Add vertical spacing between the two Text widgets
                                    Text(
                                      '4/25/2024, 12:12:54 AM',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '- Rs. 0.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const sessiondetailspage(), // Ensure this is the correct page
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '390606004301',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5), // Add vertical spacing between the two Text widgets
                                    Text(
                                      '4/25/2024, 12:12:54 AM',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '- Rs. 0.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const sessiondetailspage(), // Ensure this is the correct page
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '390606004301',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5), // Add vertical spacing between the two Text widgets
                                    Text(
                                      '4/25/2024, 12:12:54 AM',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '- Rs. 0.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const sessiondetailspage(), // Ensure this is the correct page
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '390606004301',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5), // Add vertical spacing between the two Text widgets
                                    Text(
                                      '4/25/2024, 12:12:54 AM',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '- Rs. 0.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const sessiondetailspage(), // Ensure this is the correct page
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '390606004301',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5), // Add vertical spacing between the two Text widgets
                                    Text(
                                      '4/25/2024, 12:12:54 AM',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '- Rs. 0.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const sessiondetailspage(), // Ensure this is the correct page
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '390606004301',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5), // Add vertical spacing between the two Text widgets
                                    Text(
                                      '4/25/2024, 12:12:54 AM',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '- Rs. 0.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const sessiondetailspage(), // Ensure this is the correct page
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '390606004301',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5), // Add vertical spacing between the two Text widgets
                                    Text(
                                      '4/25/2024, 12:12:54 AM',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '- Rs. 0.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const sessiondetailspage(), // Ensure this is the correct page
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '390606004301',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5), // Add vertical spacing between the two Text widgets
                                    Text(
                                      '4/25/2024, 12:12:54 AM',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '- Rs. 0.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const sessiondetailspage(), // Ensure this is the correct page
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '390606004301',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5), // Add vertical spacing between the two Text widgets
                                    Text(
                                      '4/25/2024, 12:12:54 AM',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '- Rs. 0.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const sessiondetailspage(), // Ensure this is the correct page
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '390606004301',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5), // Add vertical spacing between the two Text widgets
                                    Text(
                                      '4/25/2024, 12:12:54 AM',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '- Rs. 0.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        // Add more Text widgets for additional lines
                      ],
                    ),
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
