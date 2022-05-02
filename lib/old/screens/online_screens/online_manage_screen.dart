import 'package:auction/nada/lib0/notification_screen.dart';
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
    RaderScreen(),
    AddPostScreeen(),
    NotificationOnlineScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.teal.shade100,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Color(0xFFf1f5fb),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: Duration(seconds: 3),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() => this._selectedIndex = index),
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.radar), label: 'Radar'),
            NavigationDestination(icon: Icon(Icons.add), label: 'Add'),
            NavigationDestination(
                icon: Icon(Icons.notification_important), label: 'Notification'),
            NavigationDestination(
                icon: Icon(Icons.person_rounded), label: 'Profile'),
          /*items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: primaryColor,
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: primaryColor,
              icon: Icon(Icons.hail_outlined),
              label: 'Auctions',
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
          ],*/
        // currentIndex: _selectedIndex,
          //selectedItemColor: Colors.yellow,
         // onTap: _onItemTapped,
          //type: BottomNavigationBarType.fixed,
          //backgroundColor: primaryColor,
          //unselectedItemColor: Colors.white,
          ],
        ),

      ),
    );
  }
}
