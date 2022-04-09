import 'package:auction/old/screens/online_screens/add_post_screeen.dart';
import 'package:auction/old/screens/online_screens/auction_screen.dart';
import 'package:auction/old/screens/online_screens/notification_screen.dart';
import 'package:auction/old/screens/online_screens/online_home_screen1.dart';
import 'package:auction/old/screens/profile_screen.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';

class OffLineMangScreen extends StatefulWidget {
  const OffLineMangScreen({Key? key}) : super(key: key);

  @override
  State<OffLineMangScreen> createState() => _OffLineMangScreenState();
}

class _OffLineMangScreenState extends State<OffLineMangScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    OnlineHome(),
    AuctionScreen(),
    AddPostScreeen(),
    NotificationScreeen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hail_outlined),
            label: 'Auctions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'AddPost',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'notifactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_rounded),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
