// import 'package:auction/nada/lib0/trade_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'offline_auction_screen.dart';
// import 'online_auction.dart';

// class StartScreen extends StatefulWidget {
//   const StartScreen({Key? key}) : super(key: key);

//   @override
//   _StartScreenState createState() => _StartScreenState();
// }

// class _StartScreenState extends State<StartScreen> {
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       /*bottomNavigationBar: BottomNavigationBar(
//         //backgroundColor: Colors.black,
//         fixedColor: Colors.teal,
//         type: BottomNavigationBarType.fixed,
//         currentIndex: currentIndex,
//         onTap: (index)
//         {
//           setState(() {
//             currentIndex=index;
//           });
//         },

//         items: [
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.home,
//               ),
//               label: 'Home Page'),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.radar,
//               ),
//               label: 'Rader'),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.add,
//               ),
//               label: 'Add'),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.message,
//               ),
//               label: 'Messages'),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.face,
//               ),
//               label: 'Profile'),
//         ],
//       ),*/
//       body: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//           fit: BoxFit.cover,
//           image: NetworkImage(
//               'https://i.pinimg.com/564x/0f/c8/7f/0fc87ffeec70af2e12ed01d22f06c2b1.jpg'),
//         )),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Auction',
//                 style: (TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 50,
//                   color: Colors.teal,
//                 )),
//               ),
//               SizedBox(
//                 height: 100,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                     width: 250,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.teal,
//                     ),
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => OnlineAuctionScreen(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Online Auction',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                       //color: Colors.teal,
//                     )),
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                     width: 250,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.teal,
//                     ),
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => OfflineAuctionScreen(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Offline Auction',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                       //color: Colors.teal,
//                     )),
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                     width: 250,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.teal,
//                     ),
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => TradeScreen(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Trade',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                       //color: Colors.teal,
//                     )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     ;
//   }
// }
