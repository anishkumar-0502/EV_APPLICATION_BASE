import 'package:flutter/material.dart';
import '../../components/elevationbutton.dart'; // Import the CustomElevatedButton widget

class WalletPage extends StatefulWidget {
  final String? userinfo;

  const WalletPage({super.key, this.userinfo});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String activeTab = 'wallet'; // Track whether wallet icon is active

  void _navigateToHomePage() {
    Navigator.pop(context); // Navigate back to the previous page
  }

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
      backgroundColor: Colors.white, // Set background color to white

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
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, top: 10, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rs.499.2',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Added SizedBox for spacing
                          Text(
                            'Balance',
                            style: TextStyle(fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 130.0), // SizedBox to create space
                    Icon(Icons.wallet_outlined, size: 63),
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
                    'Recharge',
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
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 25),
              child: Container(
                child: const Row(
                  children: [
                    Text(
                      'History Used',
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Deducted',
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Deducted',
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Deducted',
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Deducted',
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Credited',
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
                                '+ Rs. 500',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
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
      // bottomNavigationBar: CustomElevatedButton(
      //   context: context,
      //   activeTab: activeTab,
      // ),
    );
  }
}
