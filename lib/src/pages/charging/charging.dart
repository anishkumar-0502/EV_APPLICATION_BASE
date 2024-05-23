// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/elevationbutton.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
  bool checkFault = false;
  bool isErrorVisible = false;
  bool isThresholdVisible = false;
  bool isBatteryScreenVisible = false;
  bool showAlertLoading = false;
  List<Map<String, dynamic>> history = [];
  String voltage = '';
  String current = '';
  String power = '';
  String energy = '';
  String frequency = '';
  String temperature = '';

  void setIsStarted(bool value) {
    setState(() {
      isStarted = value;
    });
  }

  void setCheckFault(bool value) {
    setState(() {
      checkFault = value;
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

  void handleAlertLoadingStart() {
    setState(() {
      showAlertLoading = true;
    });
  }

  void handleAlertLodingStop() {
    setState(() {
      showAlertLoading = false;
    });
  }

  void setVoltage(String value) {
    setState(() {
      voltage = value;
    });
  }

  void setCurrent(String value) {
    setState(() {
      current = value;
    });
  }

  void setPower(String value) {
    setState(() {
      power = value;
    });
  }

  void setEnergy(String value) {
    setState(() {
      energy = value;
    });
  }

  void setFrequency(String value) {
    setState(() {
      frequency = value;
    });
  }

  void setTemperature(String value) {
    setState(() {
      temperature = value;
    });
  }

  void setHistory(Map<String, dynamic> entry) {
    setState(() {
      history.add(entry);
    });
  }

  void setChargerStatus(String value) {
    setState(() {
      chargerStatus = value;
    });
  }

  void setTimestamp(String currentTime) {
    setState(() {
      timestamp = currentTime;
    });
  }

  void appendStatusTime(String status, String currentTime) {
    setState(() {
      chargerStatus = status;
      timestamp = currentTime;
    });

    // Enable/disable buttons based on chargerStatus
    // (Implementation of button state changes would go here)
  }

  String getCurrentTime() {
    DateTime currentDate = DateTime.now();
    String currentTime = currentDate.toIso8601String();
    return formatTimestamp(currentTime as DateTime);
  }

  Map<String, dynamic> convertToFormattedJson(List<dynamic> measurandArray) {
    Map<String, dynamic> formattedJson = {};
    measurandArray.forEach((measurandObj) {
      String key = measurandObj['measurand'];
      dynamic value = measurandObj['value'];
      formattedJson[key] = value;
    });
    return formattedJson;
  }

  Future<void> fetchLastStatus(String chargerID) async {
    try {
      final response = await http.post(
        // Uri.parse('http://192.168.1.33:8052/FetchLaststatus'),
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
        } else if (status == 'Charging') {
          setIsStarted(true);
        }

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.searchChargerID.isNotEmpty) {
        fetchLastStatus(widget.searchChargerID);
      }
    });
    initializeWebSocket();
  }

  Future<void> endChargingSession(String chargerID) async {
    try {
      final Uri uri = Uri.parse(
          // 'http://192.168.1.33:8052/endChargingSession?ChargerID=$chargerID');
          'http://122.166.210.142:8052/endChargingSession?ChargerID=$chargerID');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Charging session ended: $data');
      } else {
        print(
            'Failed to end charging session. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error ending charging session: $error');
    }
  }

  void RcdMsg(Map<String, dynamic> parsedMessage) {
    final String chargerID = widget.searchChargerID;
    if (parsedMessage['DeviceID'] != chargerID) return;

    final List<dynamic> message = parsedMessage['message'];

    // Ensure the message has at least 4 elements to avoid index out of range errors
    if (message.length < 4 || message[3] == null) return;

    String ChargerStatus = '';
    String CurrentTime = ''; // Initialize CurrentTime
    String errorCode =
        message[3]['errorCode'] ?? 'NoError'; // Default to 'NoError' if null
    String vendorErrorCode =
        message[3]['vendorErrorCode'] ?? ''; // Default to empty string if null

    switch (message[2]) {
      case 'StatusNotification':
        ChargerStatus =
            message[3]['status'] ?? ''; // Default to empty string if null
        CurrentTime = formatTimestamp(DateTime.parse(message[3]['timestamp']));
        if (ChargerStatus == 'Preparing') {
          stopTimeout();
          setIsStarted(false);
        } else if (ChargerStatus == 'Available' ||
            ChargerStatus == 'Unavailable') {
          startTimeout();
          setIsStarted(false);
        } else if (ChargerStatus == 'Charging') {
          setIsStarted(true);
          handleAlertLodingStop();
        } else if (ChargerStatus == 'Finishing') {
          setIsStarted(false);
        } else if (ChargerStatus == 'Faulted') {
          setIsStarted(false);
          setCheckFault(true);
        }

        if (errorCode != 'NoError') {
          Map<String, dynamic> entry = {
            'serialNumber': history.length + 1,
            'currentTime': CurrentTime,
            'chargerStatus': ChargerStatus,
            'errorCode':
                errorCode != 'InternalError' ? errorCode : vendorErrorCode,
          };
          setHistory(entry);
          setCheckFault(true);
        } else {
          setCheckFault(false);
        }
        break;

      case 'Heartbeat':
        CurrentTime = formatTimestamp(DateTime.now());
        setState(() {
          timestamp = CurrentTime;
        });
        break;

      case 'Heartbeat':
        CurrentTime = formatTimestamp(DateTime.now());
        setState(() {
          timestamp = CurrentTime;
        });
        break;

      case 'MeterValues':
        Map<String, dynamic> meterValues = message[3]['meterValue'][0];
        Map<String, dynamic> sampledValue = meterValues['sampledValue'];
        Map<String, dynamic> formattedJson =
            convertToFormattedJson(sampledValue as List);

        setChargerStatus('Charging');
        setTimestamp(getCurrentTime());
        setVoltage(formattedJson['Voltage'] ?? '');
        setCurrent(formattedJson['Current.Import'] ?? '');
        setPower(formattedJson['Power.Active.Import'] ?? '');
        setEnergy(formattedJson['Energy.Active.Import.Register'] ?? '');
        setFrequency(formattedJson['Frequency'] ?? '');
        setTemperature(formattedJson['Temperature'] ?? '');

        print(
            '{ "V": $voltage,"A": $current,"W": $power,"Wh": $energy,"Hz": $frequency,"Kelvin": $temperature}');
        break;

      case 'Authorize':
        ChargerStatus = errorCode == 'NoError' ? 'Authorize' : 'Faulted';
        CurrentTime = formatTimestamp(DateTime.now());
        break;

      case 'FirmwareStatusNotification':
        ChargerStatus = message[3]['status']?.toUpperCase() ??
            ''; // Default to empty string if null
        CurrentTime = formatTimestamp(DateTime.now());
        break;

      case 'StopTransaction':
        setIsStarted(false);
        // Handle additional stop transaction logic here
        CurrentTime = formatTimestamp(DateTime.now());
        break;

      case 'Accepted':
        ChargerStatus = 'ChargerAccepted';
        CurrentTime = formatTimestamp(DateTime.now());
        break;

      default:
        // Handle unknown message types if necessary
        break;
    }

    if (ChargerStatus.isNotEmpty) {
      appendStatusTime(ChargerStatus, CurrentTime);
    }
  }

  void initializeWebSocket() {
    channel = WebSocketChannel.connect(
      // Uri.parse('ws://192.168.1.33:7050'),
      Uri.parse('ws://122.166.210.142:7050'),
    );

    channel.stream.listen(
      (message) {
        final parsedMessage = jsonDecode(message);
        print('Recived message: $parsedMessage');
        RcdMsg(parsedMessage);
      },
      onDone: () async {
        await endChargingSession(widget.searchChargerID);
        print('WebSocket connection closed');
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
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

  void toggleBatteryScreen() {
    setState(() {
      isBatteryScreenVisible = !isBatteryScreenVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // String? username = widget.username;
    String? ChargerID = widget.searchChargerID;

    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Charging Dashboard'),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 25.0),
              const Text(
                'CHARGER STATUS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              Text(
                ChargerID ??
                    '', // Use username parameter, or an empty string if null
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                chargerStatus,
                style: TextStyle(
                  color: chargerStatus == 'Faulted' ? Colors.red : Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                timestamp,
                style: const TextStyle(fontSize: 14),
              ),
              Image.asset(
                'assets/Image/car-2.png',
                height: 320,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the buttons horizontally
                children: [
                  ElevatedButton(
                    onPressed: toggleBatteryScreen,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFC8F0CD),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(
                          5), // Add elevation for shadow
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
                  const SizedBox(width: 20), // Add spacing between buttons
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isBatteryScreenVisible = false;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 251, 164, 153),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(
                          5), // Add elevation for shadow
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.stop, color: Colors.white, size: 15),
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: toggleErrorVisibility,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 251, 164, 153)),
                            foregroundColor:
                                const Color.fromARGB(255, 251, 164, 153),
                          ),
                          child: const Text('Show Error'),
                        ),
                        OutlinedButton(
                          onPressed: toggleThresholdVisibility,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color:
                                  Color(0xFFC8F0CD), // Use the specified color
                            ),
                            foregroundColor: const Color(
                                0xFFC8F0CD), // Use the specified color
                          ),
                          child: const Text(
                            'Show Threshold',
                            style: TextStyle(
                              color: Color.fromARGB(255, 168, 225,
                                  177), // Use the specified color
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 23, bottom: 80),
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          if (isErrorVisible)
                            history.isEmpty
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          222, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(20.0),
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
                                    child: const Center(
                                      child: Text(
                                        'History not found.',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          222, 255, 255, 255),
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
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: history.length,
                                          itemBuilder: (context, index) {
                                            Map<String, dynamic> transaction =
                                                history[index];
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              'Input PowerFailure',
                                                              style: TextStyle(
                                                                fontSize: 22,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            Text(
                                                              DateFormat(
                                                                      'MM/dd/yyyy, hh:mm:ss a')
                                                                  .format(
                                                                DateTime.parse(
                                                                        transaction[
                                                                            'time'])
                                                                    .toLocal(),
                                                              ),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        '- Rs. ${transaction['amount']}',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: transaction[
                                                                      'status'] ==
                                                                  'Credited'
                                                              ? Colors.green
                                                              : Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                if (index != history.length - 1)
                                                  const Divider(),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                          if (isThresholdVisible) // Show this container when isThresholdVisible is true
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 100, right: 15),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const Divider(),
                                    Container(
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
