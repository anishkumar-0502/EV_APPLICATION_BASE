import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/elevationbutton.dart';

class chargingpage extends StatefulWidget {
  const chargingpage({super.key});

  @override
  State<chargingpage> createState() => _chargingpageState();
}

class _chargingpageState extends State<chargingpage> {
  String activeTab = 'home'; // Initial active tab

  void setActiveTab(String newTab) {
    // Define the callback
    setState(() {
      activeTab = newTab;
    });
  }

  bool isErrorVisible = false;
  bool isThresholdVisible = false;

  void toggleErrorVisibility() {
    setState(() {
      // If we're toggling error visibility, hide threshold if it's visible
      if (!isErrorVisible) {
        isThresholdVisible = false;
      }
      isErrorVisible = !isErrorVisible;
    });
  }

  void toggleThresholdVisibility() {
    setState(() {
      // If we're toggling threshold visibility, hide error if it's visible
      if (!isThresholdVisible) {
        isErrorVisible = false;
      }
      isThresholdVisible = !isThresholdVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charging Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text(
                'CHARGER STATUS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              const Text(
                '390606004655',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'Preparing',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                '04/05/2024 14:59:04',
                style: TextStyle(fontSize: 18),
              ),
              Image.asset(
                'assets/Image/car-2.png',
                height: 320,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100, // Set desired width
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        // This style uses a Material widget with a gradient background to give the ElevatedButton a gradient color
                        backgroundColor: MaterialStateProperty.all(Colors
                            .blueAccent), // Transparent because we're adding a custom Material with gradient
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(6.0)), // Optional padding
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), // Rounded corners
                          ),
                        ),
                        elevation: MaterialStateProperty.all(
                            4.0), // Button shadow/elevation
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Start',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100, // Set desired width
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        // This style uses a Material widget with a gradient background to give the ElevatedButton a gradient color
                        backgroundColor: MaterialStateProperty.all(Colors
                            .redAccent), // Transparent because we're adding a custom Material with gradient
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(6.0)), // Optional padding
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), // Rounded corners
                          ),
                        ),
                        elevation: MaterialStateProperty.all(
                            4.0), // Button shadow/elevation
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.square,
                            color: Colors.white,
                            size: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Stop',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 17),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aligns contents to the start
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: toggleErrorVisibility,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            foregroundColor: Colors.red,
                          ),
                          child: const Text('Show Error'),
                        ),
                        OutlinedButton(
                          onPressed: toggleThresholdVisibility,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blueAccent),
                            foregroundColor: Colors.blueAccent,
                          ),
                          child: const Text('Show Threshold',
                              style: TextStyle(color: Colors.blueAccent)),
                        ),
                      ],
                    ),
                    if (isErrorVisible) // If error visibility is true, show the container
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 20.0,
                              bottom:
                                  100), // Adds some space between the row and the container
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text(
                            'An error has occurred!',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    if (isThresholdVisible) // Show this container when isThresholdVisible is true
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, bottom: 100, right: 15),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'THRESHOLD LEVEL',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const Divider(),
                              Container(
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Voltage Level:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Input under voltage - 175V and below.',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    Text(
                                      'Input over voltage - 270V and below.',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Current:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Over Current- 33A',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Frequency:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Under Frequency - 47HZ',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    Text(
                                      'Over Frequency - 53HZ',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Temperature:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Low Temperature - 0 °C. ',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    Text(
                                      'High Temperature - 58 °C.',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
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
}
