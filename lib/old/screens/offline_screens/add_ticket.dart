import 'dart:typed_data';

import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/text_field_input.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class AddTicketScreen extends StatefulWidget {
  const AddTicketScreen({Key? key}) : super(key: key);

  @override
  State<AddTicketScreen> createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _describtionController = TextEditingController();
  final TextEditingController _catigoryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  var ticketdate;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AuctionCubit.get(context).model;
        var TicketImage = AuctionCubit.get(context).TicketImage;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            title: const Text(
              'Post to',
            ),
            centerTitle: false,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  AuctionCubit.get(context).uploadTicketImage(
                    category: _catigoryController.text,
                    dateTime: ticketdate.toString(),
                    description: _describtionController.text,
                    titel: _titleController.text,
                    price: _priceController.text,
                  );
                },
                child: const Text(
                  "add Ticket",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              )
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
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (state is AuctionCreateTicketLoadingState)
                      const LinearProgressIndicator(),
                    if (state is AuctionCreateTicketLoadingState)
                      const SizedBox(
                        height: 10.0,
                      ),
                    Container(
                      height: 50,
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
                    TextFieldInput(
                        textEditingController: _titleController,
                        hintText: 'Enter Title',
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldInput(
                        textEditingController: _priceController,
                        hintText: 'Enter price',
                        textInputType: TextInputType.number),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldInput(
                        textEditingController: _describtionController,
                        hintText: 'Enter description',
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldInput(
                        textEditingController: _catigoryController,
                        hintText: 'Enter catigory',
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldInput(
                        textEditingController: _addressController,
                        hintText: 'Enter catigory',
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 20,
                    ),
                    TicketImage != null
                        ? SizedBox(
                            height: 200.0,
                            width: 200.0,
                            child: Container(
                              child: Image.file(
                                TicketImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              AuctionCubit.get(context).getTicketImage();
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.photo_library_outlined),
                                Text(
                                  'addPhoto',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                    TextButton(
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true, onChanged: (date) {
                            ticketdate = date;
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            print('confirm $date');
                            setState(() {
                              ticketdate = date;
                            });
                          },
                              currentTime: ticketdate ??
                                  DateTime(2022, 04, 10, 23, 12, 34));
                        },
                        child: ticketdate != null
                            ? Text('${ticketdate}',
                                style: TextStyle(color: Colors.blue))
                            : const Text('select date',
                                style: TextStyle(color: Colors.blue))),
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
