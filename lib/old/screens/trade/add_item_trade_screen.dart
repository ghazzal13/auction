import 'dart:typed_data';

import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

class AddItemTradeScreen extends StatefulWidget {
  const AddItemTradeScreen({Key? key}) : super(key: key);

  @override
  State<AddItemTradeScreen> createState() => _AddItemTradeScreenState();
}

class _AddItemTradeScreenState extends State<AddItemTradeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _describtionController = TextEditingController();
  final TextEditingController _catigoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  var TradeItemdate;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    try {
      _titleController.dispose();
      _priceController.dispose();
      _describtionController.dispose();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  String dropdownValue = 'Cars';
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AuctionCubit.get(context).model;
        var TradeItemImage = AuctionCubit.get(context).TradeItemImage;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            title: const Text(
              'Post to',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/222.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is AuctionCreateTradeItemLoadingState)
                        const LinearProgressIndicator(),
                      if (state is AuctionCreateTradeItemLoadingState)
                        const SizedBox(
                          height: 10.0,
                        ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(
                                '${userModel.image}',
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              '${userModel.name}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _titleController,
                        validator: ValidationBuilder(
                                requiredMessage: 'title must not be empty')
                            .minLength(4)
                            .maxLength(50)
                            .build(),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.title),
                          hintText: ' titel ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLines: 5,
                        minLines: 4,
                        controller: _describtionController,
                        validator: ValidationBuilder()
                            .minLength(40)
                            .maxLength(120)
                            .build(),
                        decoration: InputDecoration(
                          hintText: 'Enter description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TradeItemImage != null
                          ? Stack(
                              children: [
                                SizedBox(
                                  height: 200.0,
                                  width: 200.0,
                                  child: Container(
                                    child: Image.file(
                                      TradeItemImage,
                                      fit: BoxFit.cover,
                                    ),
                                    //   AspectRatio(
                                    // aspectRatio: 4 / 451,
                                  ),
                                ),
                                Positioned(
                                  top: 1,
                                  right: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      AuctionCubit.get(context)
                                          .removeTradeItemImage();
                                    },
                                    icon: const Icon(Icons.close_rounded,
                                        size: 25),
                                  ),
                                ),
                              ],
                            )
                          : TextButton(
                              onPressed: () {
                                AuctionCubit.get(context).getTradeItemImage();
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.photo_library_outlined),
                                  Text(
                                    'addPhoto',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            AuctionCubit.get(context)
                                .uploadTradeItemImage(
                              category: _catigoryController.text,
                              description: _describtionController.text,
                              titel: _titleController.text,
                            )
                                .then((value) {
                              AuctionCubit.get(context).removeTradeItemImage();
                              _describtionController.clear();
                              _titleController.clear();
                            });
                          }
                        },
                        backgroundColor: Colors.teal,
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Add An Item',
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
        );
      },
    );
  }
}
