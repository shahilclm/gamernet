import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:gamernet/screens/home.dart';
import 'package:gamernet/screens/profile.dart';
import 'package:gamernet/screens/ranktab.dart';
import 'package:gamernet/screens/search.dart';
import 'package:gamernet/screens/shorts.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0; // Corrected variable name to use camel case
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Ranktab(),
    Search(),
    ShortsPage(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Corrected variable name to use camel case
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions
            .elementAt(_selectedIndex), // Use updated variable name
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          // Background color of Bottom Navigation Bar
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                backgroundColor: Color(0xff040412),
                icon: Icon(Icons.home_filled),
                label: 'Home'),
            BottomNavigationBarItem(
                backgroundColor: Color(0xff040412),
                icon: Icon(Icons.leaderboard),
                label: 'Rank'),
            BottomNavigationBarItem(
                backgroundColor: Color(0xff040412),
                icon: Icon(FontAwesomeIcons.search),
                label: 'Search'),
            BottomNavigationBarItem(
                backgroundColor: Color(0xff040412),
                icon: Icon(Icons.library_music),
                label: 'Shorts'),
            BottomNavigationBarItem(
                backgroundColor: Color(0xff040412),
                icon: Icon(Icons.person_rounded),
                label: 'Profile'),
          ],
          currentIndex: _selectedIndex, // Use updated variable name
          selectedItemColor: Color(0xFF932EFF), // Color for the selected item
          unselectedItemColor: Colors.grey, // Set unselected item color
          onTap: _onItemTapped, // Corrected function name
        ),
      ),
    );
  }
}
