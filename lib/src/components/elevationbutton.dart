import 'package:flutter/material.dart';
import '../pages/home.dart'; // Adjust to your project's structure
import '../pages/Wallet/wallet.dart';
import '../pages/History/history.dart'; // Adjust import paths accordingly
import '../pages/profile/profile.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({Key? key, required this.activeTab}) : super(key: key);

  final String activeTab;

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  void _navigateTo(BuildContext context, Widget targetPage) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        bottom: 10.0,
      ), // Additional padding for the floating button
      child: Material(
        borderRadius: BorderRadius.circular(25),
        elevation: 5,
        color: const Color(0xFFC8F0CD),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.activeTab != 'home') {
                      _navigateTo(context, const HomePage());
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home,
                        color: widget.activeTab == 'home'
                            ? Colors.black
                            : Colors.black45,
                        size: 35,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          color: widget.activeTab == 'home'
                              ? Colors.black
                              : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.activeTab != 'wallet') {
                      _navigateTo(context, WalletPage());
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wallet_outlined,
                        color: widget.activeTab == 'wallet'
                            ? Colors.black
                            : Colors.black45,
                        size: 35,
                      ),
                      Text(
                        'Wallet',
                        style: TextStyle(
                          color: widget.activeTab == 'wallet'
                              ? Colors.black
                              : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.activeTab != 'history') {
                      _navigateTo(context, const historypage());
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.history,
                        color: widget.activeTab == 'history'
                            ? Colors.black
                            : Colors.black54,
                        size: 35,
                      ),
                      Text(
                        'History',
                        style: TextStyle(
                          color: widget.activeTab == 'history'
                              ? Colors.black
                              : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.activeTab != 'profile') {
                      _navigateTo(context, const profilepage());
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: widget.activeTab == 'profile'
                            ? Colors.black
                            : Colors.black54,
                        size: 35,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: widget.activeTab == 'profile'
                              ? Colors.black
                              : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
