import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/elevationbutton.dart';

class chargingpage extends StatefulWidget {
    final String? username; // Make the username parameter nullable
  const chargingpage({Key? key, this.username}) : super(key: key);

  @override
  State<chargingpage> createState() => _ChargingPageState();
}

class _ChargingPageState extends State<chargingpage> {
  String activeTab = 'home'; // Initial active tab

  void setActiveTab(String newTab) {
    // Define the callback
    setState(() {
      activeTab = newTab;
    });
  }

  bool isErrorVisible = false;
  bool isThresholdVisible = false;

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

  bool isBatteryScreenVisible = false;

  void toggleBatteryScreen() {
    setState(() {
      isBatteryScreenVisible = !isBatteryScreenVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
        String? username = widget.username;

    return Scaffold(
      appBar: AppBar(
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
              const Text(
                '390606004655',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'Status',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                '04/05/2024 14:59:04',
                style: TextStyle(fontSize: 18),
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
