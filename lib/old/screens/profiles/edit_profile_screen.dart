import 'dart:typed_data';

import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/theme.dart';
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
  final TextEditingController _descriptionController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();

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
            title: const Text('Edit Profile'),
            actions: [
              TextButton(
                child: const Text(
                  'update',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  AuctionCubit.get(context).upLoadProfileImage();
                },
              ),
              const SizedBox(
                width: 15.0,
              ),
            ],
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
                    padding: const EdgeInsets.all(8.0),
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
                                          backgroundImage:
                                              FileImage(profileImage),
                                          backgroundColor: Colors.red,
                                        )
                                      : CircleAvatar(
                                          radius: 100,
                                          backgroundImage: NetworkImage(
                                              '${userModel.image}'),
                                          backgroundColor: Colors.red,
                                        ),
                                  Positioned(
                                    bottom: -10,
                                    left: 80,
                                    child: IconButton(
                                      onPressed: () {
                                        AuctionCubit.get(context)
                                            .getProfileImage();
                                      },
                                      icon: const Icon(Icons.add_a_photo),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              defaultFormField(
                                controller: titleController,
                                type: TextInputType.text,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'title must not be empty';
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
                                controller: descriptionController,
                                type: TextInputType.text,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'title must not be empty';
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
                                  controller: priceController,
                                  type: TextInputType.number,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'address',
                                  prefix: Icons.place),
                              const SizedBox(
                                height: 15.0,
                              ),
                            ]))))),
          ),
        );
      },
    );
  }
}
