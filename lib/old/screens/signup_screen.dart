import 'dart:typed_data';
import 'package:auction/cubit/cubit.dart';
import 'package:auction/old/resources/auth_method.dart';
import 'package:auction/old/screens/home_screen.dart';
import 'package:auction/old/screens/login_screen.dart';
import 'package:auction/service/local_push_notification.dart';
import 'package:auction/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _addressController.dispose();
  }

  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      address: _addressController.text,
      name: _nameController.text,
    );
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => const HomeScreeen()),
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreeen()),
          (route) => false);
      // User currentUser = FirebaseAuth.instance.currentUser!;
      AuctionCubit.get(context).getUserData().then((value) {
        FirebaseMessaging.instance.getInitialMessage();
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          LocalNotificationService.display(message);
        });
        storeNotificationToken();

        // FirebaseMessaging.instance.subscribeToTopic('subscription');
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/222.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                    height: 200,
                    child: Image(
                      image: AssetImage('assets/logo1.png'),
                    )),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFieldInput(
                    hintText: 'Enter your Name',
                    textInputType: TextInputType.text,
                    textEditingController: _nameController,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFieldInput(
                    hintText: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFieldInput(
                    hintText: 'Enter your password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFieldInput(
                    hintText: 'Enter your address',
                    textInputType: TextInputType.text,
                    textEditingController: _addressController,
                  ),
                ),

                // InkWell(
                //   child: Container(
                //     child: !_isLoading
                //         ? const Text(
                //             'Sign up',
                //           )
                //         : const CircularProgressIndicator(
                //             color: primaryColor,
                //           ),
                //     width: double.infinity,
                //     alignment: Alignment.center,
                //     padding: const EdgeInsets.symmetric(vertical: 12),
                //     decoration: const ShapeDecoration(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(4)),
                //       ),
                //       color: blueColor,
                //     ),
                //   ),
                //   onTap: signUpUser,
                // ),
                // const SizedBox(
                //   height: 12,
                // ),
                const SizedBox(
                  height: 22,
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      child: !_isLoading
                          ? const Text(
                              'Sign up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            )
                          : const CircularProgressIndicator(
                              color: (Colors.white),
                            ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(colors: [
                            Colors.teal.shade300,
                            Colors.greenAccent.shade200
                          ])),
                    ),
                  ),
                  onTap: signUpUser,
                  // => Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const HomeScreeen(),
                  //   ),
                  // ),
                ),

                // Flexible(
                //   child: Container(),
                //   flex: 2,
                // ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(
                        'Already have an account?',
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                      child: Container(
                        child: const Text(
                          ' Login.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
