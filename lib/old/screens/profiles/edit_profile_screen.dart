import 'dart:typed_data';

import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // pickImage(ImageSource source) async {
  //   final ImagePicker _imagePicker = ImagePicker();
  //   XFile? _file = await _imagePicker.pickImage(source: source);
  //   if (_file != null) {
  //     return await _file.readAsBytes();
  //   }
  //   print('No Image Selected');
  // }

  // Uint8List? _file;
  // bool isLoading = false;

  final TextEditingController _descriptionController = TextEditingController();

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
                child: const Text('update'),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // if (state is AuctionUserUpdateLoadingState)
                    //   const LinearProgressIndicator(),
                    // if (state is AuctionUserUpdateLoadingState)
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
