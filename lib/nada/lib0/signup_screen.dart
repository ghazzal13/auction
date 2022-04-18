// import 'dart:typed_data';
// import 'package:auction/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'resources/auth_method.dart';
// import 'text_field_input.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({Key? key}) : super(key: key);

//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _nationalidController = TextEditingController();
//   final TextEditingController _creditcardController = TextEditingController();

//   bool _isLoading = false;
//   Uint8List? _image;

//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _usernameController.dispose();
//   }

//   // selectImage() async {
//   //   Uint8List im = await pickImage(ImageSource.gallery);
//   //   // set state because we need to display the image we selected on the circle avatar
//   //   setState(() {
//   //     _image = im;
//   //   });
//   // }

//   void signUpUser() async {
//     // set loading to true
//     setState(() {
//       _isLoading = true;
//     });

//     String res = await AuthMethods().signUpUser(
//       email: _emailController.text,
//       password: _passwordController.text,
//       username: _usernameController.text,
//       address: _addressController.text,
//     );
//     if (res == "success") {
//       setState(() {
//         _isLoading = false;
//       });
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const HomePagesScreen()),
//       );
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       // show the error
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
//           child: SingleChildScrollView(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 32),
//               width: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [

//                   Padding(
//                     padding: const EdgeInsets.all(40),
//                     child: Container(
//                        // height: 150,
//                         child: const Image(
//                           image: AssetImage('assets/logo1.png'),
//                         )),
//                   ),
//                   // SvgPicture.asset(
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.all(13),
//                     child: TextFieldInput(
//                       hintText: 'Enter your username',
//                       textInputType: TextInputType.text,
//                       textEditingController: _usernameController,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(13),
//                     child: TextFieldInput(
//                       hintText: 'Enter your email',
//                       textInputType: TextInputType.emailAddress,
//                       textEditingController: _emailController,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(13),
//                     child: TextFieldInput(
//                       hintText: 'Enter your password',
//                       textInputType: TextInputType.text,
//                       textEditingController: _passwordController,
//                       isPass: true,
//                     ),
//                   ),

//                   Padding(
//                     padding: const EdgeInsets.all(13),
//                     child: TextFieldInput(
//                       hintText: 'Enter your address',
//                       textInputType: TextInputType.text,
//                       textEditingController: _addressController,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(13),
//                     child: TextFieldInput(
//                       hintText: 'Enter your national ID',
//                       textInputType: TextInputType.text,
//                       textEditingController: _nationalidController,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(13),
//                     child: TextFieldInput(
//                       hintText: 'Enter Your Mobile Number ',
//                       textInputType: TextInputType.number,
//                      textEditingController: _creditcardController,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width*0.5,
//                       height: 50,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                         gradient: LinearGradient(colors: [Colors.teal.shade200,Colors.greenAccent.shade100]),
//                       ),
//                       child: TextButton(onPressed: (){
//                         Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => const StartScreen(),
//                             ), );
//                       },
//                           child: Text('Sign UP',
//                             style: TextStyle(
//                               color: Colors.teal[600],
//                               fontWeight: FontWeight.w500,
//                               fontSize: 30,
//                             ),)),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   /*Flexible(
//                     child: Container(),
//                     flex: 2,
//                   ),*/
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         child: const Text(
//                           'Already have an account?',
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                       ),
//                       GestureDetector(
//                         onTap: () => Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => const LoginScreen(),
//                           ),
//                         ),
//                         child: Container(
//                           child: const Text(
//                             ' Login.',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
