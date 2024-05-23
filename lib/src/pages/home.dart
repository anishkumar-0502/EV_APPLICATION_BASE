import 'package:flutter/material.dart';
import '../components/elevationbutton.dart'; // Correct import
import './charging/charging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String? userinfo;
  const HomePage({super.key, this.userinfo});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activeTab = 'home'; // Initial active tab
  List<String> recentSessionDetails = []; // To store the session details
  String searchChargerID = '';

  @override
  void initState() {
    super.initState();
    fetchRecentSessionDetails(); // Fetch data when the widget initializes
  }

  void fetchRecentSessionDetails() async {
    String? username = widget.userinfo;

    try {
      final response = await http.get(Uri.parse(
          // 'http://192.168.1.33:8052/getRecentSessionDetails?username=$username'));
          'http://122.166.210.142:8052/getRecentSessionDetails?username=$username'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          recentSessionDetails = List<String>.from(
              data['value']); // Assuming the response is a list of strings
        });
      } else {
        throw Exception('Failed to load recent session details');
      }
    } catch (error) {
      print('Error fetching Recent Charger: $error');
    }
  }

  Future<void> handleSearchRequest(String searchChargerID) async {
    try {
      final response = await http.post(
        // Uri.parse('http://192.168.1.33:8052/SearchCharger'),
        Uri.parse('http://122.166.210.142:8052/SearchCharger'),

        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            {'searchChargerID': searchChargerID, 'Username': widget.userinfo}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        setState(() {
          this.searchChargerID = searchChargerID;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                chargingpage(searchChargerID: searchChargerID),
          ),
        );
      } else {
        final errorData = json.decode(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(errorData['message']),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void handleSearchRecent(String searchChargerID) async {
    await handleSearchRequest(searchChargerID);
  }

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 40.0, right: 230.0),
            child: Container(
              color: Colors.transparent, // Set container color to transparent
              child: Image.asset(
                'assets/Image/EV_Logo2.png',
                height: 30,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Image.asset('assets/Image/Car.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      onSubmitted: handleSearchRecent,
                      decoration: InputDecoration(
                        hintText: 'Enter DeviceID',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => handleSearchRecent(searchChargerID),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24.0),
                                bottomRight: Radius.circular(24.0),
                              ),
                              color: Colors.green,
                            ),
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchChargerID = value;
                        });
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 25),
                    child: Row(
                      children: [
                        Text(
                          'Previously Used ',
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
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 100.0),
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
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 18.0),
                        child: recentSessionDetails.isEmpty
                            ? Container(
                                padding: const EdgeInsets.all(14.0),
                                child: const Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // This ensures the column takes minimal space
                                    children: [
                                      SizedBox(
                                          height:
                                              9), // Add spacing above the text
                                      Text(
                                        'Yet to charge ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          // color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.only(top: 17.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      for (int index = 0;
                                          index < recentSessionDetails.length;
                                          index++)
                                        InkWell(
                                          onTap: () {
                                            handleSearchRecent(
                                                recentSessionDetails[index]);
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    recentSessionDetails[index],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (index !=
                                                  recentSessionDetails.length -
                                                      1)
                                                const Divider(),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingButton(
        activeTab: activeTab,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
