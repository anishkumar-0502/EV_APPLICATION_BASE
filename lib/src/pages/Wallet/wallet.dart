import 'dart:convert';
import 'package:flutter/material.dart';
import '../../components/elevationbutton.dart'; // Import the CustomElevatedButton widget
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatefulWidget {
  final String? username; // Make the username parameter nullable

  const WalletPage({
    Key? key,
    this.username, // Mark the username parameter as nullable
  }) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late Razorpay _razorpay;
  String activeTab = 'wallet';
  double? walletBalance;
  List<Map<String, dynamic>> transactionDetails =
      []; // Define transactionDetails as an empty list
  double? _lastPaymentAmount; // Store the last payment amount

  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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

    try {
      var response = await http.get(Uri.parse(
          // 'http://192.168.1.33:8052/GetWalletBalance?username=$username'));
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

    try {
      var response = await http.get(Uri.parse(
          // 'http://192.168.1.33:8052/getTransactionDetails?username=$username'));
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

  @override
  void dispose() {
    _razorpay.clear();
    _amountController.dispose();
    super.dispose();
  }

  void handlePayment(double amount) async {
    String? username = widget.username;
    const String currency = 'INR';
    try {
      var response = await http.post(
        Uri.parse('http://122.166.210.142:8052/createOrder'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'amount': amount, // amount in paise
          'currency': currency,
        }),
      );
      var data = json.decode(response.body);
      print(data);
      Map<String, dynamic> options = {
        'key': 'rzp_test_dcep4q6wzcVYmr',
        'amount': data['amount'],
        'currency': data['currency'],
        'name': 'Outdid Tech',
        'description': 'Wallet Recharge',
        'order_id': data['id'],
        'prefill': {'name': username},
        'theme': {'color': '#3399cc'},
      };
      _lastPaymentAmount = amount; // Store the amount

      _razorpay.open(options);
    } catch (error) {
      print('Error during payment: $error');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    String? username = widget.username;
    try {
      Map<String, dynamic> result = {
        'user': username,
        'RechargeAmt': _lastPaymentAmount, // Use the stored amount
        'transactionId': response.orderId,
        'responseCode': 'SUCCESS',
        'date_time': DateTime.now().toString(),
      };

      var output = await http.post(
        Uri.parse('http://122.166.210.142:8052/savePayments'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(result),
      );

      var responseData = json.decode(output.body);
      print(responseData);
      if (responseData == 1) {
        print('Payment successful!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WalletPage(
              username: username,
            ),
          ),
        );
      } else {
        print('Payment details not saved!');
      }
    } catch (error) {
      print('Error saving payment details: $error');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error: ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
  }

  // UI method to build the amount container widget
  Widget _buildAmountContainer(double amount) {
    return GestureDetector(
      onTap: () {
        handlePayment(amount);
      },
      child: Container(
        padding: const EdgeInsets.all(12.2),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 217, 212),
          borderRadius: BorderRadius.circular(15.0),
          // border: Border.all(
          //   color: Colors.red.withOpacity(0.5),
          // ),
        ),
        child: Text(
          'Rs. ${amount.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                    Expanded(
                      child: Padding(
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
                                fontSize: 23,
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
                    ),
                    const SizedBox(width: 10.0),
                    const Padding(
                      padding: EdgeInsets.only(
                          right: 15.0), // Add padding to the right of the icon
                      child: Icon(Icons.wallet_outlined, size: 63),
                    ),
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
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(width: 10.0),
                  Icon(Icons.currency_rupee),
                ],
              ),
            ),
            // Amount buttons
            Padding(
              padding: const EdgeInsets.only(
                  left: 38.0, right: 30.0, top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAmountContainer(500),
                  _buildAmountContainer(1000),
                  _buildAmountContainer(2000),
                ],
              ),
            ),
            // Text Field and Submit Button Row
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 17.0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType:
                            TextInputType.number, // Set keyboard type to number
                        decoration: const InputDecoration(
                          hintText: 'Enter Amount',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                        ),
                        controller: _amountController, // Assign the controller
                      ),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: TextButton(
                      onPressed: () {
                        // Handle submit button pressed
                        // Extract amount from the text field and pass it to handlePayment function
                        double amount =
                            double.tryParse(_amountController.text) ?? 0.0;
                        if (amount > 0) {
                          handlePayment(amount);
                          _amountController
                              .clear(); // Clear the text field after submission
                        } else {
                          // Handle invalid input or amount
                          // Display a message or take appropriate action
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 219, 249, 223),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
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
              child: transactionDetails.isEmpty
                  ? Container(
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
                          'history not found.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      // Display transaction history if available
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
                        child: Scrollbar(
                          child: Column(
                            children: [
                              for (int index = 0;
                                  index < transactionDetails.length;
                                  index++)
                                Column(
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
                                                  transactionDetails[index]
                                                      ['status'],
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  DateFormat(
                                                          'MM/dd/yyyy, hh:mm:ss a')
                                                      .format(
                                                    DateTime.parse(
                                                            transactionDetails[
                                                                index]['time'])
                                                        .toLocal(),
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '${transactionDetails[index]['status'] == 'Credited' ? '+ Rs. ' : '- Rs. '}${transactionDetails[index]['amount']}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: transactionDetails[index]
                                                          ['status'] ==
                                                      'Credited'
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    if (index != transactionDetails.length - 1)
                                      const Divider(),
                                  ],
                                ),
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
