import 'package:auction/nada/lib0/bidding_screen.dart';
import 'package:auction/nada/lib0/custom_nav_bar.dart';
import 'package:auction/nada/lib0/favorite_screen.dart';
import 'package:auction/nada/lib0/lost_screen.dart';
import 'package:auction/nada/lib0/search_screen.dart';
import 'package:auction/old/screens/search_screen.dart';
import 'package:auction/old/screens/shopping_cart_screen.dart';
import 'package:auction/nada/lib0/sort_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../nada/lib0/notification_screen.dart';
import 'notification_screen.dart';

class RaderScreen extends StatefulWidget {
  const RaderScreen({Key? key}) : super(key: key);

  @override
  _RaderScreenState createState() => _RaderScreenState();
}

class _RaderScreenState extends State<RaderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'My Radar',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
              unselectedLabelColor: Colors.green.shade300,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.teal.shade300, Colors.tealAccent.shade400]),
                borderRadius: BorderRadius.circular(30),
                // color: Colors.teal.shade200,
              ),
              tabs: [
                Container(
                    decoration: (BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white10, width: 1),
                    )),
                    alignment: Alignment.center,
                    child: Tab(
                      text: ('Bidding'),
                    )),
                Container(
                    alignment: Alignment.center,
                    child: Tab(
                      text: ('Favorite'),
                    )),
                Container(
                    alignment: Alignment.center,
                    child: Tab(
                      text: ('Lost'),
                    )),
              ]),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartScreen(),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: (Icon(Icons.category)),
            ),
            /*IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> SearchScreen(),
                ),);
              },
               icon: (Icon(Icons.menu)),
            ),*/
            PopupMenuButton(
                tooltip: 'Menu',
                child: Icon(
                  Icons.more_vert,
                  size: 28.0,
                  color: Colors.white,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchOnlineScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            (Icon(
                              Icons.search,
                              color: Colors.teal,
                              size: 30,
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      )),
                  PopupMenuItem(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SortScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            (Icon(
                              Icons.sort,
                              color: Colors.teal,
                              size: 30,
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Sort By',
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      )),
                ]),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://i.pinimg.com/564x/0f/c8/7f/0fc87ffeec70af2e12ed01d22f06c2b1.jpg'),
              )),
          child: Center(
            child: TabBarView(children: [
              BiddingScreen(),
              FavoriteScreen(),
              LostScreen(),
            ]),
          ),
        ),
      ),
    );
  }
}
