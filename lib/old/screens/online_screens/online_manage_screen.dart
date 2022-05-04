import 'package:auction/old/screens/online_screens/add_post_screeen.dart';
import 'package:auction/old/screens/online_screens/auction_screen.dart';
import 'package:auction/old/screens/online_screens/notification_screen.dart';
import 'package:auction/old/screens/online_screens/online_home_screen1.dart';
import 'package:auction/old/screens/profiles/user_profile_screen.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';

class OnlineMangScreen extends StatefulWidget {
  const OnlineMangScreen({Key? key}) : super(key: key);

  @override
  State<OnlineMangScreen> createState() => _OnlineMangScreenState();
}

class _OnlineMangScreenState extends State<OnlineMangScreen> {
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
            backgroundColor: primaryColor,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(Icons.hail_outlined),
            label: 'My Auctions',
          ),
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(Icons.add),
            label: 'AddPost',
          ),
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(Icons.date_range),
            label: 'notifactions',
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
