import 'dart:typed_data';

import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/screens/online_screens/online_manage_screen.dart';
import 'package:auction/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/reuse_component.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuctionCubit.get(context).removeProfileImage();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 0) {
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
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (conttext, state) {},
      builder: (context, state) {
        var userModel = AuctionCubit.get(context).model;
        var profileImage = AuctionCubit.get(context).profileImage;

        nameController.text = userModel.name!;
        emailController.text = userModel.email!;
        addressController.text = userModel.address!;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text('Edit Profile'),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/222.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (state is AuctionUserUpdateLoadingState)
                          const LinearProgressIndicator(),
                        if (state is AuctionUserUpdateLoadingState)
                          const SizedBox(
                            height: 10.0,
                          ),
                        Stack(
                          children: [
                            profileImage != null
                                ? CircleAvatar(
                                    radius: 100,
                                    backgroundImage: FileImage(profileImage),
                                    backgroundColor: Colors.red,
                                  )
                                : CircleAvatar(
                                    radius: 100,
                                    backgroundImage:
                                        NetworkImage('${userModel.image}'),
                                    backgroundColor: Colors.red,
                                  ),
                            Positioned(
                              bottom: -10,
                              left: 80,
                              child: IconButton(
                                onPressed: () {
                                  AuctionCubit.get(context).getProfileImage();
                                },
                                icon: const Icon(Icons.add_a_photo),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          label: 'name',
                          prefix: Icons.account_box,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          label: 'email',
                          prefix: Icons.alternate_email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: addressController,
                            type: TextInputType.number,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'address must not be empty';
                              }
                              return null;
                            },
                            label: 'address',
                            prefix: Icons.place),
                        const SizedBox(
                          height: 150.0,
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            if (profileImage != null) {
                              AuctionCubit.get(context).upLoadProfileImage();
                            }
                            if (formKey.currentState!.validate()) {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                'name': nameController.text,
                                'email': emailController.text,
                                'address': addressController.text
                              }, SetOptions(merge: true));
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
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
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
