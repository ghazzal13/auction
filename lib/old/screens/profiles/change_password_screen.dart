import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/auth_method.dart';
import 'package:auction/old/resources/reuse_component.dart';
import 'package:auction/old/resources/text_field_input.dart';
import 'package:auction/old/screens/online_screens/online_manage_screen.dart';
import 'package:auction/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

import '../login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordconferimController =
      TextEditingController();
  var isPassword = true;
  var isLogin = false;

  final int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.pop(context);
    } else {
      setState(() {
        AuctionCubit.get(context).onItemTapped(index);

        print(index);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const OnlineMangScreen()),
            (route) => false);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    passwordconferimController.dispose();
    oldpasswordController.dispose();
  }

  void loginUser(String email, String password) async {
    String res =
        await AuthMethods().loginUser(email: email, password: password);
    if (res == 'success') {
      setState(() {
        isLogin = true;
      });
    } else {
      showSnackBar(context, res);
    }
  }

  final user = FirebaseAuth.instance.currentUser;
  changePassword(String yourPassword) async {
    await user!.updatePassword(yourPassword).then((_) {
      FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
          .pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false));
    }).catchError((error) {
      print("Error " + error.toString());
      showToast(text: error, state: ToastStates.ERROR);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (conttext, state) {},
      builder: (context, state) {
        var userModel = AuctionCubit.get(context).model;
        var profileImage = AuctionCubit.get(context).profileImage;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text('Change Password'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      isLogin == true
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: isPassword,
                                  validator: ValidationBuilder(
                                          requiredMessage: 'can not be empty')
                                      .minLength(6)
                                      .maxLength(50)
                                      .build(),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.teal,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.teal,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    suffixIcon: isPassword != true
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isPassword = !isPassword;
                                              });
                                            },
                                            icon: const Icon(
                                                Icons.remove_red_eye_outlined))
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isPassword = !isPassword;
                                              });
                                            },
                                            icon: const Icon(
                                                Icons.remove_red_eye_rounded)),
                                    hintText: ' password',
                                    contentPadding: const EdgeInsets.all(8),
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                  controller: passwordconferimController,
                                  obscureText: isPassword,
                                  validator: ValidationBuilder(
                                          requiredMessage: 'can not be empty')
                                      .minLength(6)
                                      .maxLength(50)
                                      .build(),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.teal,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.teal,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    suffixIcon: isPassword != true
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isPassword = !isPassword;
                                              });
                                            },
                                            icon: const Icon(
                                                Icons.remove_red_eye_outlined))
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isPassword = !isPassword;
                                              });
                                            },
                                            icon: const Icon(
                                                Icons.remove_red_eye_rounded)),
                                    hintText: ' confirm password',
                                    contentPadding: const EdgeInsets.all(8),
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                FloatingActionButton.extended(
                                  onPressed: () {
                                    if (profileImage != null) {
                                      AuctionCubit.get(context)
                                          .upLoadProfileImage();
                                    }
                                    if (formKey.currentState!.validate()) {
                                      if (passwordController.text !=
                                          passwordconferimController.text) {
                                        showToast(
                                            text: 'Is Not The Same',
                                            state: ToastStates.ERROR);
                                      } else {
                                        changePassword(passwordController.text);
                                      }
                                    }
                                  },
                                  backgroundColor: Colors.teal,
                                  icon: const Icon(Icons.save_outlined),
                                  label: const Text(
                                    'save',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                  controller: oldpasswordController,
                                  obscureText: isPassword,
                                  validator: ValidationBuilder(
                                          requiredMessage: 'can not be empty')
                                      .minLength(6)
                                      .maxLength(50)
                                      .build(),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.teal,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.teal,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    suffixIcon: isPassword != true
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isPassword = !isPassword;
                                              });
                                            },
                                            icon: const Icon(
                                                Icons.remove_red_eye_outlined))
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isPassword = !isPassword;
                                              });
                                            },
                                            icon: const Icon(
                                                Icons.remove_red_eye_rounded)),
                                    hintText: ' old password',
                                    contentPadding: const EdgeInsets.all(8),
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                FloatingActionButton.extended(
                                  onPressed: () {
                                    if (profileImage != null) {
                                      AuctionCubit.get(context)
                                          .upLoadProfileImage();
                                    }
                                    if (formKey.currentState!.validate()) {
                                      loginUser(userModel.email.toString(),
                                          oldpasswordController.text);
                                    }
                                  },
                                  backgroundColor: Colors.teal,
                                  icon: const Icon(Icons.save_outlined),
                                  label: const Text(
                                    'confirm',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(Icons.menu),
                label: 'Menu',
              ),
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
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: primaryColor,
            unselectedItemColor: Colors.white,
          ),
        );
      },
    );
  }
}
