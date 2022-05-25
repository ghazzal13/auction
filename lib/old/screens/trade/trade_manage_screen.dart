import 'package:auction/old/screens/profiles/my_profile_screen.dart';
import 'package:auction/old/screens/trade/add_item_trade_screen.dart';
import 'package:auction/old/screens/trade/trade_home_screen.dart';
import 'package:auction/old/screens/trade/user_offers_screen.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';

class TradeMangScreen extends StatefulWidget {
  const TradeMangScreen({Key? key}) : super(key: key);

  @override
  State<TradeMangScreen> createState() => _TradeMangScreenState();
}

class _TradeMangScreenState extends State<TradeMangScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    TradeHomeScreen(),
    AddItemTradeScreen(),
    UserOffersScreen(),
    ProfileScreen(),
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
            label: 'Add Item',
          ),
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(Icons.check_box_outlined),
            label: 'My Offers',
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
