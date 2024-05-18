// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/elevationbutton.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

String formatTimestamp(DateTime originalTimestamp) {
  String day = originalTimestamp.day.toString().padLeft(2, '0');
  String month = originalTimestamp.month.toString().padLeft(2, '0');
  String year = originalTimestamp.year.toString();
  String hours = originalTimestamp.hour.toString().padLeft(2, '0');
  String minutes = originalTimestamp.minute.toString().padLeft(2, '0');
  String seconds = originalTimestamp.second.toString().padLeft(2, '0');
  return '$day/$month/$year $hours:$minutes:$seconds';
}

class chargingpage extends StatefulWidget {
  final String? username; // Make the username parameter nullable
  final String searchChargerID;

  const chargingpage({super.key, this.username, required this.searchChargerID});

  @override
  State<chargingpage> createState() => _ChargingPageState();
}

class _ChargingPageState extends State<chargingpage> {
  String activeTab = 'home';
  late WebSocketChannel channel;
  
  String chargerStatus = '';
  String timestamp = '';
  bool isTimeoutRunning = false;
  bool isStarted = false;

  void setIsStarted(bool value) {
    setState(() {
      isStarted = value;
    });
  }

  void startTimeout() {
    setState(() {
      isTimeoutRunning = true;
    });
  }

  void stopTimeout() {
    setState(() {
      isTimeoutRunning = false;
    });
  }

  void appendStatusTime(String status, String currentTime) {
    setState(() {
      chargerStatus = status;
      timestamp = currentTime;
    });

    // Enable/disable buttons based on chargerStatus
    if (status == 'Preparing') {
      // Enable start button
      // Disable stop button
    } else if (status == 'Charging') {
      // Enable stop button
      // Disable start button
    }
  }

  Future<void> fetchLastStatus(String chargerID) async {
    try {
      final response = await http.post(
        Uri.parse('http://122.166.210.142:8052/FetchLaststatus'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': chargerID}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['message']['status'];
        final formattedTimestamp =
            formatTimestamp(DateTime.parse(data['message']['timestamp']));

        if (status == 'Available' || status == 'Unavailable') {
          startTimeout();
        }
        if (status == 'Charging') {
          setIsStarted(true);
        }

        setState(() {
          chargerStatus = status;
          timestamp = formattedTimestamp;
        });

        appendStatusTime(status, formattedTimestamp);
      } else {
        print('Failed to fetch status. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error while fetching status: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final searchChargerID = widget.searchChargerID;
      if (searchChargerID.isNotEmpty) {
        fetchLastStatus(searchChargerID);
      }
    });
    initializeWebSocket();
  }

  Future<void> endChargingSession(String chargerID) async {
    print(chargerID);

    try {
      final Uri uri = Uri.parse(
          'http://122.166.210.142:8052/endChargingSession?ChargerID=$chargerID');
      final response = await http.get(uri);
      print(response);
      final datas = jsonDecode(response.body);
      print(datas);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
      } else {
        print(
            'Failed to end charging session. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error ending charging session: $error');
    }
  }

  void initializeWebSocket() {
    String? chargerID = widget.searchChargerID;

    // Connect to the WebSocket server
    channel = WebSocketChannel.connect(
      Uri.parse('ws://122.166.210.142:7050'),
    );

    // Print WebSocket connection open message
    print('WebSocket connection open');

    // Listen for WebSocket events
    channel.stream.listen(
      (message) {
        // Handle received message
        final parsedMessage = jsonDecode(message);
        setState(() {
          chargerStatus = parsedMessage['status'];
          timestamp = parsedMessage['timestamp'];
        });
        print('Received message: $parsedMessage');
      },
      onDone: () async {
        // Handle WebSocket connection close
        print('WebSocket connection closed');
        await endChargingSession(chargerID);
        print(chargerID);
      },
      onError: (error) {
        // Handle WebSocket error
        print('WebSocket error: $error');
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    // Close the WebSocket connection
    channel.sink.close();
    super.dispose();
  }

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

  bool isErrorVisible = false;
  bool isThresholdVisible = false;
  bool isBatteryScreenVisible = false;

  void toggleBatteryScreen() {
    setState(() {
      isBatteryScreenVisible = !isBatteryScreenVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? username = widget.username;
    String? ChargerID = widget.searchChargerID;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              Text(
                ChargerID ??
                    '', // Use username parameter, or an empty string if null                style: TextStyle(fontSize: 20),
              ),
              Text(
                chargerStatus,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                timestamp,
                style: const TextStyle(fontSize: 18),
              ),
              Image.asset(
                'assets/Image/car-2.png',
                height: 320,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: toggleBatteryScreen,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.play_arrow, color: Colors.white),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Start',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isBatteryScreenVisible = false;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.square, color: Colors.white, size: 15),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Stop',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isBatteryScreenVisible) // Conditional rendering based on isBatteryScreenVisible
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      BatteryChargeScreen(),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green[300]!,
                                      Colors.green[700]!
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(
                                    16), // Optional padding
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly, // Evenly space the text elements
                                  children: [
                                    Text(
                                      'A',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      'A',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      'A',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green[300]!,
                                      Colors.green[700]!
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(
                                    16), // Optional padding
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly, // Evenly space the text elements
                                  children: [
                                    Text(
                                      'A',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      'A',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      'A',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
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
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 17, bottom: 100),
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

class BatteryChargeScreen extends StatefulWidget {
  @override
  _BatteryChargeScreenState createState() => _BatteryChargeScreenState();
}

class _BatteryChargeScreenState extends State<BatteryChargeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _animation = Tween<double>(begin: 0, end: 100).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: BatteryPainter(_animation.value),
        child: Container(
          width: 200,
          height: 70,
        ),
      ),
    );
  }
}

class BatteryPainter extends CustomPainter {
  final double chargeLevel;

  BatteryPainter(this.chargeLevel);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Draw battery body
    final bodyRect = Rect.fromLTWH(10, 10, size.width - 20, size.height - 20);
    canvas.drawRect(bodyRect, paint);

    // Draw battery tip
    final tipRect =
        Rect.fromLTWH(size.width - 10, size.height / 2 - 10, 10, 20);
    canvas.drawRect(tipRect, paint);

    // Draw charge level
    final chargePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final chargeRect = Rect.fromLTWH(
        15, 15, (size.width - 30) * (chargeLevel / 100), size.height - 30);
    canvas.drawRect(chargeRect, chargePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
