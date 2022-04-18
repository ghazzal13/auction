
// import 'package:auction/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'resources/auth_method.dart';
// import 'signup_screen.dart';
// import 'text_field_input.dart';
// import 'theme.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }

//   void loginUser() async {
//     setState(() {
//       _isLoading = true;
//     });
//     String res = await AuthMethods().loginUser(
//         email: _emailController.text, password: _passwordController.text);
//     if (res == 'success') {
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const HomePagesScreen()));

//       setState(() {
//         _isLoading = false;
//       });
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       showSnackBar(context, res);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/222.jpg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             width: double.infinity,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Flexible(
//                   child: Container(),
//                   flex: 2,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(60),
//                   child: Container(
//                      // height: 150,
//                       child: const Image(
//                         image: AssetImage('assets/logo1.png'),
//                       )),
//                 ),
//                 // SvgPicture.asset(
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.all(13),
//                   child: TextFieldInput(
//                     hintText: 'Enter your email',
//                     textInputType: TextInputType.emailAddress,
//                     textEditingController: _emailController,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(13),
//                   child: TextFieldInput(
//                     hintText: 'Enter your password',
//                     textInputType: TextInputType.text,
//                     textEditingController: _passwordController,
//                     isPass: true,
//                   ),
//                 ),
//                 InkWell(
//                   child: Padding(
//                     padding: const EdgeInsets.all(13),
//                     child: Container(
//                       child: !_isLoading
//                           ? const Text(
//                               'Log in',
//                             )
//                           : const CircularProgressIndicator(
//                               color: (Colors.white),
//                             ),
//                       width: double.infinity,
//                       alignment: Alignment.center,
//                       padding: EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         gradient: LinearGradient(colors: [Colors.teal.shade200,Colors.greenAccent.shade100]),
//                       )

//                     ),
//                   ),
//                   onTap: () => Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const StartScreen(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 Flexible(
//                   child: Container(),
//                   flex: 2,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       child: const Text(
//                         'Dont have an account?',
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => const SignupScreen(),
//                         ),
//                       ),
//                       child: Container(
//                         child: const Text(
//                           ' Signup.',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
