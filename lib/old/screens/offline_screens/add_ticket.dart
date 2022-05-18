import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/reuse_component.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';

class AddTicketScreen extends StatefulWidget {
  const AddTicketScreen({Key? key}) : super(key: key);

  @override
  State<AddTicketScreen> createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _describtionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime ticketdate = DateTime(1, 1, 1, 1);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AuctionCubit.get(context).model;
        var TicketImage = AuctionCubit.get(context).TicketImage;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            title: const Text(
              'AddTicket',
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
                      if (state is AuctionCreateTicketLoadingState)
                        const LinearProgressIndicator(),
                      if (state is AuctionCreateTicketLoadingState)
                        const SizedBox(
                          height: 10.0,
                        ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.teal,
                              backgroundImage: NetworkImage(
                                '${userModel.image}',
                              ),
                            ),
                            const SizedBox(
                              width: 10,
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
                      TextFormField(
                        controller: _priceController,
                        validator: ValidationBuilder(
                                requiredMessage: 'price must not be empty')
                            .maxLength(10)
                            .build(),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.paid),
                          hintText: ' price ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _addressController,
                        validator: ValidationBuilder(
                                requiredMessage: 'address must not be empty')
                            .minLength(4)
                            .maxLength(50)
                            .build(),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: ' address ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TicketImage != null
                          ? Stack(
                              children: [
                                SizedBox(
                                  height: 200.0,
                                  width: 200.0,
                                  child: Container(
                                    child: Image.file(
                                      TicketImage,
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
                                          .removeTicketImage();
                                    },
                                    icon: const Icon(Icons.close_rounded,
                                        size: 25),
                                  ),
                                ),
                              ],
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                              maxTime:
                                  DateTime.now().add(const Duration(days: 20)),
                              minTime: DateTime.now(),
                              currentTime: ticketdate != DateTime(1, 1, 1, 1)
                                  ? ticketdate
                                  : DateTime.now());
                        },
                        child: ticketdate != DateTime(1, 1, 1, 1)
                            ? Text(
                                ' ${DateFormat.yMd().add_jm().format(ticketdate)}',
                                style: const TextStyle(color: Colors.blue))
                            : const Text(
                                'select date',
                                style: TextStyle(color: Colors.blue),
                              ),
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          if (TicketImage != null ||
                              formKey.currentState!.validate()) {
                            if (formKey.currentState!.validate()) {
                              if (ticketdate != DateTime(1, 1, 1, 1)) {
                                AuctionCubit.get(context)
                                    .uploadTicketImage(
                                  address: _addressController.text,
                                  dateTime: ticketdate,
                                  description: _describtionController.text,
                                  titel: _titleController.text,
                                  price: int.parse(_priceController.text),
                                )
                                    .then((value) {
                                  AuctionCubit.get(context).removeTicketImage();
                                  ticketdate = DateTime(1, 1, 1, 1);
                                  _titleController.clear();
                                  _priceController.clear();
                                  _describtionController.clear();
                                  _addressController.clear();
                                });
                              } else {
                                showToast(
                                    text: 'select date',
                                    state: ToastStates.ERROR);
                              }
                            }
                          } else {
                            showToast(
                                text: 'Add Image', state: ToastStates.ERROR);
                          }
                        },
                        backgroundColor: Colors.teal,
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Add ticket',
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
