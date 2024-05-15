import 'dart:convert';
import 'package:flutter/material.dart';
import '../../components/elevationbutton.dart'; // Import the CustomElevatedButton widget
import 'package:http/http.dart' as http;

class WalletPage extends StatefulWidget {
  final String? username; // Make the username parameter nullable

  const WalletPage({
    super.key,
    this.username, // Mark the username parameter as nullable
  });

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String activeTab = 'wallet';
  double? walletBalance;
  List<Map<String, dynamic>> transactionDetails =
      []; // Define transactionDetails as an empty list

  @override
  void initState() {
    super.initState();
    fetchWallet(); // Fetch wallet balance when the page is initialized
    fetchTransactionDetails();
  }

  // Method to set wallet balance
  void setWalletBalance(double balance) {
    setState(() {
      walletBalance = balance.toDouble(); // Convert integer to double
    });
  }

  // Function to fetch wallet balance
  void fetchWallet() async {
    String? username = widget.username;
    print('Fetching wallet balance for user: $username ');

    try {
      var response = await http.get(Uri.parse(
          'http://122.166.210.142:8052/GetWalletBalance?username=$username'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setWalletBalance(data['balance'].toDouble()); // Cast to double
      } else {
        throw Exception('Failed to load wallet balance');
      }
    } catch (error) {
      print('Error fetching wallet balance: $error');
    }
  }

  // Function to set transaction details
  void setTransactionDetails(List<Map<String, dynamic>> value) {
    setState(() {
      transactionDetails = value;
    });
  }

// Function to fetch transaction details
  void fetchTransactionDetails() async {
    String? username = widget.username;
    print('Fetching transaction details for user: $username ');

    try {
      var response = await http.get(Uri.parse(
          'http://122.166.210.142:8052/getTransactionDetails?username=$username'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['value'] is List) {
          List<dynamic> transactionData = data['value'];
          List<Map<String, dynamic>> transactions =
              transactionData.cast<Map<String, dynamic>>();
          setTransactionDetails(transactions);
        } else {
          throw Exception('Transaction details format is incorrect');
        }
      } else {
        throw Exception('Failed to load transaction details');
      }
    } catch (error) {
      print('Error fetching transaction details: $error');
    }
  }

  // UI method to build the amount container widget
  Widget _buildAmountContainer(String amount) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFB9AE),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.red.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      child: Text(
        amount,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Wallet'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main content at the top
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10.0,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, top: 10, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            walletBalance != null
                                ? 'Rs. ${walletBalance?.toStringAsFixed(2)}'
                                : 'Fetching...', // Display the wallet balance dynamically
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Balance',
                            style: TextStyle(fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 130.0),
                    const Icon(Icons.wallet_outlined, size: 63),
                  ],
                ),
              ),
            ),

            // Recharge section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Row(
                children: [
                  Text(
                    'Recharge ',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10.0),
                  Icon(Icons.currency_rupee),
                ],
              ),
            ),
            // Amount buttons
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAmountContainer('Rs.500'),
                  _buildAmountContainer('Rs.1000'),
                  _buildAmountContainer('Rs.2000'),
                ],
              ),
            ),
            // Text Field and Submit Button Row
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.0), // Apply left margin
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Amount', // Placeholder text
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width:
                          30.0), // Spacer between TextField and Submit button
                  Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: TextButton(
                      onPressed: () {
                        // Handle submit button pressed
                        // Implement your submit logic here
                      },
                      style: TextButton.styleFrom(
                        // Text color of the button
                        backgroundColor: const Color(0xFFC8F0CD),

                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0), // Button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            color: Colors.green, // Border color of the button
                            width: 1.0, // Border width
                          ),
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0, left: 25),
              child: Row(
                children: [
                  Text(
                    'History ',
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
                      children: transactionDetails.map((transaction) {
                        return Column(
                          children: [
                            GestureDetector(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transaction['status'],
                                          style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          transaction['time'],
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '- Rs. ${transaction['amount']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: transaction['status'] == 'Credited'
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(), // Add a Divider widget after each Row
                          ],
                        );
                      }).toList(),
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
      // bottomNavigationBar: CustomElevatedButton(
      //   context: context,
      //   activeTab: activeTab,
      // ),
    );
  }
}
