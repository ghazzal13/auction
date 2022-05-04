// import 'package:auction/nada/lib0/start_screen.dart';
// import 'package:auction/theme.dart';
// import 'package:flutter/material.dart';

// import 'theme.dart';

// class HomeScreeen extends StatelessWidget {
//   const HomeScreeen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/222.jpg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => const StartScreen()));
//                   },
//                   child: Container(
//                     height: 80,
//                     child: const Text('Online Auction',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold)),
//                     width: double.infinity,
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: const ShapeDecoration(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                     height: 80,
//                     child: const Text(
//                       'Offline Auction',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     width: double.infinity,
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: const ShapeDecoration(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                     height: 80,
//                     child: const Text('Trade',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold)),
//                     width: double.infinity,
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: const ShapeDecoration(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
