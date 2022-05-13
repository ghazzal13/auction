import 'package:auction/old/screens/online_screens/add_post_screeen.dart';
import 'package:auction/old/screens/online_screens/auction_screen.dart';
import 'package:auction/old/screens/online_screens/online_home_screen1.dart';
import 'package:auction/old/screens/profiles/user_profile_screen.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class OnlineMangScreen extends StatefulWidget {
  const OnlineMangScreen({Key? key}) : super(key: key);

  @override
  State<OnlineMangScreen> createState() => _OnlineMangScreenState();
}

class _OnlineMangScreenState extends State<OnlineMangScreen> {
  static const List<Widget> _widgetOptions = <Widget>[
    OnlineHome(),
    AuctionScreen(),
    AddPostScreeen(),
    ProfileScreen()
  ];
  void onselect(int x) {
    setState(() {
      AuctionCubit.get(context).onItemTapped(x);
    });
  }

  @override
  void initState() {
    super.initState();
    AuctionCubit.get(context).selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body:
              _widgetOptions.elementAt(AuctionCubit.get(context).selectedIndex),
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
                icon: Icon(Icons.account_circle),
                label: 'profile',
              ),
            ],
            currentIndex: AuctionCubit.get(context).selectedIndex,
            selectedItemColor: Colors.yellow,
            onTap: onselect,
            type: BottomNavigationBarType.fixed,
            backgroundColor: primaryColor,
            unselectedItemColor: Colors.white,
          ),
        );
      },
    );
  }
}
