import 'package:auction/old/screens/offline_screens/add_ticket.dart';
import 'package:auction/old/screens/offline_screens/offline_home_screen.dart';
import 'package:auction/old/screens/profiles/user_profile_screen.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';

class OfflineMangScreen extends StatefulWidget {
  const OfflineMangScreen({Key? key}) : super(key: key);

  @override
  State<OfflineMangScreen> createState() => _OfflineMangScreenState();
}

class _OfflineMangScreenState extends State<OfflineMangScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    OfflineHomeScreen(),
    AddTicketScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(Icons.add),
            label: 'Add Ticket',
          ),
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(Icons.account_circle),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
