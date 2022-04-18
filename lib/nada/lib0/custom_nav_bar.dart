import 'package:auction/nada/lib0/message_screen.dart';
import 'package:auction/nada/lib0/rader_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatefulWidget {
  const CustomButtom({Key? key}) : super(key: key);

  @override
  _CustomButtomState createState() => _CustomButtomState();
}

class _CustomButtomState extends State<CustomButtom> {
  /* List<Widget> screens=
      [
        RaderScreen(),
      ];*/
  @override
  int index = 0;
  /* final screens =
  [
    RaderScreen(),
    OnlineAuctionScreen(),
  ];*/

  Widget build(BuildContext context) {
    return
        //body: screens[index],
        NavigationBarTheme(
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
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RaderScreen(),
                    ),
                  );
                },
                child: NavigationDestination(
                    icon: Icon(Icons.radar), label: 'Radar')),
            NavigationDestination(icon: Icon(Icons.add), label: 'Add'),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageScreen(),
                    ),
                  );
                },
                child: NavigationDestination(
                    icon: Icon(Icons.message), label: 'Message')),
            NavigationDestination(
                icon: Icon(Icons.person_rounded), label: 'Profile'),
          ]),
    );
    // body:screens[currentIndex],
    /*  BottomNavigationBar(
        //backgroundColor: Colors.black,
        fixedColor: Colors.teal,
     type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
      setState(() {
        currentIndex = index;
      });
    },

    items: [
    BottomNavigationBarItem(
    icon: Icon(
    Icons.home,
    ),
    label: 'Home Page'),
    BottomNavigationBarItem(
    icon: GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> RaderScreen(),
        ),);
      },
      child: Icon(
      Icons.radar,
      ),
    ),
    label: 'Rader'),
    BottomNavigationBarItem(
    icon: Icon(
    Icons.add,
    ),
    label: 'Add'),
    BottomNavigationBarItem(
    icon: Icon(
    Icons.message,
    ),
    label: 'Messages'),
    BottomNavigationBarItem(
    icon: Icon(
    Icons.face,
    ),
    label: 'Profile'),
    ],
    );*/
  }
}
