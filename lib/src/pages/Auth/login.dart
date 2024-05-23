import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utilities/User_Model/user.dart';
import '../Home.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final List<TextEditingController> _passwordControllers =
      List.generate(4, (_) => TextEditingController());

  String? storedUser;

  @override
  void initState() {
    super.initState();
    // Retrieve user data from shared preferences when the app starts
    _retrieveUserData();
  }

  Future<void> _retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedUser = prefs.getString('user');
    });
  }

  Future<void> _login() async {
    String username = _usernameController.text;
    final String password = _passwordControllers.map((c) => c.text).join('');

    try {
      var response = await http.post(
        // Uri.parse('http://192.168.1.33:8052/CheckLoginCredentials'),
        Uri.parse('http://122.166.210.142:8052/CheckLoginCredentials'),

        body: {
          'loginUsername': username,
          'loginPassword': password,
        },
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', username);
        Provider.of<UserData>(context, listen: false).updateUserData(username);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => HomePage(
                    userinfo: username,
                  )),
        );
      } else {
        _showDialog('Error', 'Login failed');
      }
    } catch (e) {
      _showDialog('Error', 'An error occurred: $e');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return storedUser != null
        ? const HomePage() // Navigate to HomePage if user is already logged in
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white, // Set background color to white

              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(23.0),
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
                        padding: const EdgeInsets.all(20.0),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    _passwordControllers.length,
                                    (index) {
                                      return SizedBox(
                                        width: 50,
                                        child: TextField(
                                          controller:
                                              _passwordControllers[index],
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 10.0,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            if (value.isNotEmpty &&
                                                index <
                                                    _passwordControllers
                                                            .length -
                                                        1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ),
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
                                      onPressed: _login,
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
                                        'SignIn',
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage(),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    text: 'New User? ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' Sign Up',
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
