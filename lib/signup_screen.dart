import 'dart:typed_data';
import 'package:auction/home_screen.dart';
import 'package:auction/login_screen.dart';
import 'package:auction/resources/auth_method.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nationalidController = TextEditingController();
  final TextEditingController _creditcardController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  // selectImage() async {
  //   Uint8List im = await pickImage(ImageSource.gallery);
  //   // set state because we need to display the image we selected on the circle avatar
  //   setState(() {
  //     _image = im;
  //   });
  // }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      address: _addressController.text,
    );
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreeen()),
      );
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
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/222.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Container(
                    height: 150,
                    child: const Image(
                      image: AssetImage('assets/logo1.png'),
                    )),
                // SvgPicture.asset(
                // ),
                const SizedBox(
                  height: 24,
                ),
                // Stack(
                //   children: [
                //     _image != null
                //         ? CircleAvatar(
                //             radius: 64,
                //             backgroundImage: MemoryImage(_image!),
                //             backgroundColor: Colors.red,
                //           )
                //         : const CircleAvatar(
                //             radius: 64,
                //             backgroundImage: NetworkImage(
                //                 'https://i.stack.imgur.com/l60Hf.png'),
                //             backgroundColor: Colors.red,
                //           ),
                //     Positioned(
                //       bottom: -10,
                //       left: 80,
                //       child: IconButton(
                //         onPressed: () {},
                //         // onPressed: selectImage,
                //         icon: const Icon(Icons.add_a_photo),
                //       ),
                //     )
                //   ],
                // ),
                // const SizedBox(
                //   height: 24,
                // ),
                TextFieldInput(
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                  textEditingController: _usernameController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  isPass: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your address',
                  textInputType: TextInputType.text,
                  textEditingController: _addressController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your national ID',
                  textInputType: TextInputType.text,
                  textEditingController: _nationalidController,
                ),
                const SizedBox(
                  height: 24,
                ),

                TextFieldInput(
                  hintText: 'Enter your credit card ',
                  textInputType: TextInputType.number,
                  textEditingController: _creditcardController,
                ),
                const SizedBox(
                  height: 24,
                ),

                InkWell(
                    child: Container(
                      child: !_isLoading
                          ? const Text(
                              'Sign up',
                            )
                          : const CircularProgressIndicator(
                              color: (Colors.white),
                            ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: primaryColor,
                      ),
                    ),
                    /*
                  
                  */
                    onTap: signUpUser),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  child: Container(),
                  flex: 2,
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
