import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:login_page/Audio/screen/audio.dart';
import 'package:login_page/notes/screen/notes.dart';
// import 'package:login_page/profile/screen/profilescreen.dart';
import 'package:login_page/expense_tracker/screen/expense.dart';



class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentIndex = 0;
  final List<Widget> _Screens = [
    // HomeScreen(),
    Notes(),
    Audio(),
    Expense(),
    
  ];
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _Screens[_currentIndex],
      bottomNavigationBar: Container(
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01, horizontal: screenWidth * 0.02),
          child: GNav(
            backgroundColor: Color(0xFFFFFFFF),
            color: Color(0xFF000000),
            activeColor: Color(0xFF000000),
            tabBackgroundColor: Color(0xFFFFFFFF),
            gap: screenWidth * 0.02,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            padding: const EdgeInsets.all(24),
            tabs: const [
              GButton(
                icon: Icons.notes,
                text: 'Notes',
              ),
              GButton(
                icon: Icons.audiotrack_outlined,
                text: 'Audio',
              ),
              GButton(
                icon: Icons.monetization_on,
                text: 'Expense Tracker',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
