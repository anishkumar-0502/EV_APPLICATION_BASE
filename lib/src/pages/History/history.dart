import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../components/elevationbutton.dart';
import 'sessiondetails.dart';
import 'package:http/http.dart' as http;

class historypage extends StatefulWidget {
  final String? username; // Make the username parameter nullable
  const historypage({super.key, this.username});

  @override
  State<historypage> createState() => _historypageState();
}

class _historypageState extends State<historypage> {
  String activeTab = 'history'; // Initial active tab
  List<Map<String, dynamic>> SessionDetails = [];

  @override
  void initState() {
    super.initState();
    fetchChargingSessionDetails();
  }

  // Function to set session details
  void setSessionDetails(List<Map<String, dynamic>> value) {
    setState(() {
      SessionDetails = value;
    });
  }

  // Function to fetch charging session details
  void fetchChargingSessionDetails() async {
    String? username = widget.username;

    try {
      var response = await http.get(Uri.parse(
          // 'http://192.168.1.33:8052/getChargingSessionDetails?username=$username'));
          'http://122.166.210.142:8052/getChargingSessionDetails?username=$username'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['value'] is List) {
          List<dynamic> chargingSessionData = data['value'];
          List<Map<String, dynamic>> sessionDetails =
              chargingSessionData.cast<Map<String, dynamic>>();
          setSessionDetails(sessionDetails);
        } else {
          throw Exception('Session details format is incorrect');
        }
      } else {
        throw Exception('Failed to load session details');
      }
    } catch (error) {
      print('Error fetching session details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('History'),
      ),
      body: SingleChildScrollView(
        child: Scrollbar(
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
              SessionDetails.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
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
                        padding: const EdgeInsets.all(20.0),
                        child: const Center(
                          child: Text(
                            ' session history not found.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 90),
                      child: Container(
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
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Container(
                            child: Column(
                              children: [
                                for (int index = 0;
                                    index < SessionDetails.length;
                                    index++)
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              sessiondetailspage(
                                                  sessionData:
                                                      SessionDetails[index]),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    SessionDetails[index]
                                                            ['ChargerID']
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 19,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    SessionDetails[index][
                                                                'StartTimestamp'] !=
                                                            null
                                                        ? DateFormat(
                                                                'MM/dd/yyyy, hh:mm:ss a')
                                                            .format(
                                                            DateTime.parse(
                                                                    SessionDetails[
                                                                            index]
                                                                        [
                                                                        'StartTimestamp'])
                                                                .toLocal(),
                                                          )
                                                        : "-",
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black54,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '- Rs. ${SessionDetails[index]['price']}',
                                              style: const TextStyle(
                                                fontSize: 19,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        if (index != SessionDetails.length - 1)
                                          const Divider(),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
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
}
