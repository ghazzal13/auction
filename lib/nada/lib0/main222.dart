
// import 'package:auction/chat_screen.dart';
// import 'package:auction/editprofile_screen.dart';
// import 'package:auction/login_screen.dart';
// import 'package:auction/message_screen.dart';
// import 'package:auction/online_auction.dart';
// import 'package:auction/posts_screen.dart';
// import 'package:auction/profile_screen.dart';
// import 'package:auction/rader_screen.dart';
// import 'package:auction/rating_screen.dart';
// import 'package:auction/signup_screen.dart';
// import 'package:auction/start_screen.dart';
// import 'package:auction/username_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'home_pages_screen.dart';
// import 'online_comments_screen.dart';
// import 'login_screen.dart';
// import 'offline_auction_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(),
//       home: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.hasData) {
//               return const HomePagesScreen();
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text('${snapshot.error}'),
//               );
//             }
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ProfileScreen();
//           },
//       ),
//       //  const SignupScreen(),
//     );
//   }
// }
