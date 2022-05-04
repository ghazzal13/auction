import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/reuse_component.dart';
import 'package:auction/old/screens/online_screens/auction_screen.dart';
import 'package:auction/theme.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';

class AddPostScreeen extends StatefulWidget {
  const AddPostScreeen({Key? key}) : super(key: key);

  @override
  State<AddPostScreeen> createState() => _AddPostScreeenState();
}

class _AddPostScreeenState extends State<AddPostScreeen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _describtionController = TextEditingController();
  final TextEditingController _catigoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime postdate = DateTime(1, 1, 1, 1);

  late String category;
  late String _myActivityResult;

  @override
  void initState() {
    super.initState();
    category = '';
    _myActivityResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      setState(() {
        _myActivityResult = category;
      });
    }
  }

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
        var postImage = AuctionCubit.get(context).postImage;
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
            // actions: <Widget>[
            //   TextButton(
            //     onPressed: () {
            //       final formattedStr = DateTime.now();
            //       // formatDate(DateTime.now(),
            //       //     [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);

            //       DateTime now = DateTime.now();
            //       if (formKey.currentState!.validate()) {
            //         AuctionCubit.get(context)
            //             .uploadPostImage(
            //           category: dropdownValue.toString(),
            //           startAuction: postdate,
            //           postTime: now,
            //           description: _describtionController.text,
            //           titel: _titleController.text,
            //           price: int.parse(_priceController.text),
            //         )
            //             .whenComplete(() {
            //           AuctionCubit.get(context).removePostImage();
            //           Navigator.of(context).pushReplacement(
            //             MaterialPageRoute(
            //               builder: (context) => const AuctionScreen(),
            //             ),
            //           );
            //         });
            //       }
            //     },
            //     child: const Text(
            //       "Post",
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 16.0),
            //     ),
            //   )
            // ],
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
                      if (state is AuctionCreatePostLoadingState)
                        const LinearProgressIndicator(),
                      if (state is AuctionCreatePostLoadingState)
                        const SizedBox(
                          height: 10.0,
                        ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.teal,
                              backgroundImage: NetworkImage(
                                '${userModel.image}',
                              ),
                            ),
                            const SizedBox(
                              width: 15,
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLines: 5,
                        minLines: 4,
                        controller: _describtionController,
                        validator: ValidationBuilder()
                            .minLength(120)
                            .maxLength(250)
                            .build(),
                        decoration: InputDecoration(
                          hintText: 'Enter description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextFormField(
                              controller: _priceController,
                              validator: ValidationBuilder(
                                      requiredMessage:
                                          'price must not be empty')
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
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 9, 87, 65)),
                            underline: Container(
                              height: 2,
                              color: Color.fromARGB(255, 10, 137, 97),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>[
                              'Cars',
                              'Mobiles',
                              'Antiques',
                              'Paintings',
                              'Furniture',
                              'Electrical Devices',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      postImage != null
                          ? Stack(
                              children: [
                                SizedBox(
                                  height: 200.0,
                                  width: 200.0,
                                  child: Container(
                                    child: Image.file(
                                      postImage,
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
                                          .removePostImage();
                                    },
                                    icon: const Icon(Icons.close_rounded,
                                        size: 25),
                                  ),
                                ),
                              ],
                            )
                          : TextButton(
                              onPressed: () {
                                AuctionCubit.get(context).getPostImage();
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
                            formatDate(date,
                                [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
                            postdate = date;
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            print('confirm $date');
                            setState(() {
                              postdate = date;
                            });
                          },
                              maxTime:
                                  DateTime.now().add(const Duration(days: 20)),
                              minTime: DateTime.now(),
                              currentTime: DateTime.now());
                        },
                        child: postdate != DateTime(1, 1, 1, 1)
                            ? Text(
                                ' ${DateFormat.yMd().add_jm().format(postdate)}',
                                style: const TextStyle(color: Colors.blue))
                            : const Text(
                                'select date',
                                style: TextStyle(color: Colors.blue),
                              ),
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          if (postImage != null ||
                              formKey.currentState!.validate()) {
                            DateTime now = DateTime.now();
                            if (formKey.currentState!.validate()) {
                              if (postdate != DateTime(1, 1, 1, 1)) {
                                AuctionCubit.get(context)
                                    .uploadPostImage(
                                  category: dropdownValue.toString(),
                                  startAuction: postdate,
                                  postTime: now,
                                  description: _describtionController.text,
                                  titel: _titleController.text,
                                  price: int.parse(_priceController.text),
                                )
                                    .then((value) {
                                  AuctionCubit.get(context).removePostImage();
                                  postdate = DateTime(1, 1, 1, 1);
                                  _titleController.clear();
                                  _priceController.clear();
                                  _describtionController.clear();
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
                          'Add Post',
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
