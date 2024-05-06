import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _passwordControllers =
      List.generate(4, (_) => TextEditingController());

  void _handleRegister() async {
    final String username = _usernameController.text;
    final String phone = _phoneController.text;
    final String password = _passwordControllers.map((c) => c.text).join('');

    // Validation can be more robust depending on requirements
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(username)) {
      _showAlert('Username must contain only letters.');
      return;
    }

    if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
      _showAlert('Phone number must be a 10-digit number.');
      return;
    }

    if (!RegExp(r'^\d{4}$').hasMatch(password)) {
      _showAlert('Password must be a 4-digit number.');
      return;
    }

    try {
      var response = await http.post(
        // Uri.parse('http://192.168.1.11:8052/RegisterNewUser'),
        Uri.parse('http://122.166.210.142:8052/RegisterNewUser'),

        body: {
          'registerUsername': username,
          'registerPhone': phone,
          'registerPassword': password,
        },
      );

      if (response.statusCode == 200) {
        // Handle successful registration
        Navigator.pop(
            context); // Assuming you want to pop back after registration
      } else {
        _showAlert('Registration failed');
      }
    } catch (e) {
      _showAlert('An error occurred: $e');
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // Set background color to white

        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(
                23.0), // Main padding for the entire content
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10.0,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(20.0), // Padding for inner content
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          'assets/Image/EV_Logo2.png',
                          height: 40,
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            controller: _usernameController,
                          ),
                        ],
                      ),
                      const SizedBox(height: 50.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(_passwordControllers.length,
                                (index) {
                              return SizedBox(
                                width: 50,
                                child: TextField(
                                  controller: _passwordControllers[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty &&
                                        index <
                                            _passwordControllers.length - 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0),
                            child: Container(
                              margin: const EdgeInsets.only(right: 20.0),
                              child: ElevatedButton(
                                onPressed: _handleRegister,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 52.0),
                                  ),
                                ),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 27.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginPage(
                                title: 'LoginPage',
                              ),
                            ));
                          },
                          child: RichText(
                            text: const TextSpan(
                              text:
                                  'Already a User? ', // Added a space after "New User?"
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Sign In',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
