import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../components/elevationbutton.dart';

class ProfileSettingPage extends StatefulWidget {
  final String? username; // Make the username parameter nullable
  const ProfileSettingPage({super.key, this.username});

  @override
  State<ProfileSettingPage> createState() => _settingspageState();
}

class _settingspageState extends State<ProfileSettingPage> {
  String activeTab = 'profile';
  // Initial active tab

  void setActiveTab(String newTab) {
    // Define the callback
    setState(() {
      activeTab = newTab;
    });
  }

  bool lightTime = false;
  bool lightUnit = false;
  bool lightPrice = false;

  void onSwitchChangedTime(bool newValue) {
    setState(() {
      lightTime = newValue; // Update switch state for 'Time'
    });
  }

  void onSwitchChangedUnit(bool newValue) {
    setState(() {
      lightUnit = newValue; // Update switch state for 'Unit'
    });
  }

  void onSwitchChangedPrice(bool newValue) {
    setState(() {
      lightPrice = newValue; // Update switch state for 'Price'
    });
  }

  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() => _onTextChanged(i));
    }
  }

  void _onTextChanged(int index) {
    if (_controllers[index].text.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus(); // Move to next field
    } else if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus(); // Move back when deleting
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white

      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextField()
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phoneno',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextField()
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            height: 10), // Spacing between text and TextField
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 30, // Reducing height of the TextField
                                child: TextField(
                                  maxLength: 1,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            0), // Reducing padding for smaller size
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Spacer(flex: 1), // Equal spacing between TextFields
                            Expanded(
                              child: SizedBox(
                                height: 30,
                                child: TextField(
                                  maxLength: 1,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Spacer(flex: 1), // Equal spacing between TextFields
                            Expanded(
                              child: SizedBox(
                                height: 30,
                                child: TextField(
                                  maxLength: 1,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Spacer(flex: 1), // Equal spacing between TextFields
                            Expanded(
                              child: SizedBox(
                                height: 30,
                                child: TextField(
                                  maxLength: 1,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Auto Stop Based on:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Switch(
                              value: lightTime,
                              onChanged: onSwitchChangedTime,
                            ),
                            const Text('Time',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const Text(
                              "min's",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Switch(
                              value: lightUnit,
                              onChanged: onSwitchChangedUnit,
                            ),
                            const Text('Unit',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const Text(
                              'unit',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Switch(
                              value: lightPrice,
                              onChanged: onSwitchChangedPrice,
                            ),
                            const Text('Price',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const Text(
                              'Rs',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      // This is where the action for the submit button is defined
                      print('Submit button pressed!');
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ), // Label for the button
                  ),
                ),
              ],
            ),
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
