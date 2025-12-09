import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AquaMoreScreen.dart';
import 'AquaTransactionsScreen.dart';
import 'HomePage.dart';

const _blue = Color(0xFF007AFF);
const _grey = Color(0xFF8E8E93);

class AquaBottomNavShell extends StatefulWidget {
  const AquaBottomNavShell({super.key});

  @override
  State<AquaBottomNavShell> createState() => _AquaBottomNavShellState();
}

class _AquaBottomNavShellState extends State<AquaBottomNavShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    AquaHomeScreen(),
    AquaTransactionsScreen(),
    AquaHomeScreen(), // Pay (dummy screen for now)
    AquaHomeScreen(), // My Card
    AquaMoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE5E5EA), // very light grey divider
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },

          // ✅ iOS aqua colours
          selectedItemColor: _blue,
          unselectedItemColor: _grey,

          iconSize: 26,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedLabelStyle: GoogleFonts.arimo(
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          unselectedLabelStyle: GoogleFonts.arimo(
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          showUnselectedLabels: true,

          items: [
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.doc_text),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: _PayIcon(
                color: _grey,
                borderColor: _grey,
              ),
              activeIcon: _PayIcon(
                color: _blue,
                borderColor: _blue,
              ),
              label: 'Pay',
            ),
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.creditcard),
              label: 'My Card',
            ),
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.ellipsis),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}

/// Circular "Pay" icon jaisa screenshot me hai
class _PayIcon extends StatelessWidget {
  final Color color;
  final Color borderColor;

  const _PayIcon({
    required this.color,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Icon(
        CupertinoIcons.arrow_right,
        size: 18,
        color: color,
      ),
    );
  }
}
