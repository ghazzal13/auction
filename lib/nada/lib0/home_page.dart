
// import 'package:auction/signup_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'login_screen.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/222.jpg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//                 child:  Image(
//                   image: AssetImage('assets/logo1.png',),

//                 )),
//             SizedBox(
//               height: 70,
//             ),
//             Container(
//               height: 55,
//               width: MediaQuery.of(context).size.width*0.5,
//               decoration: (
//                   BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.teal,

//                   )
//               ),
//               child: TextButton(onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context)=> LoginScreen(),
//                 ),);
//               },
//                 child: Text('Login',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                   ),),
//                 //color: Colors.teal,

//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               height: 55,
//               width: MediaQuery.of(context).size.width*0.5,
//               decoration: (
//                   BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.teal,

//                   )
//               ),
//               child: TextButton(onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context)=> SignupScreen(),
//                 ),);
//               },
//                 child: Text('Signup',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                   ),),
//                 //color: Colors.teal,

//               ),
//             ),
//           ],
//         ),
//       ),

//     );
//   }
// }
