import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:form_validator/form_validator.dart';

class EditPostScreen extends StatefulWidget {
  final Map post1;
  final String postId;
  const EditPostScreen(
    String string, {
    Key? key,
    required this.post1,
    required this.postId,
  }) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState(
        postId: postId,
        post1: post1,
      );
}

class _EditPostScreenState extends State<EditPostScreen> {
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _priceController = TextEditingController();
  late TextEditingController _describtionController = TextEditingController();
  DateTime postdate = DateTime(1, 1, 1, 1);

  late String category;
  late String _myActivityResult;

  var postId;

  var post1;

  _EditPostScreenState({
    required this.postId,
    required this.post1,
  });

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
          var postmmm = AuctionCubit.get(context).postByID;

          _titleController.text = post1['titel'];
          _priceController.text = post1['price'];
          _describtionController.text = post1['description'];
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text(
                'Edit Post',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    final formattedStr = DateTime.now();

                    DateTime now = DateTime.now();
                    if (formKey.currentState!.validate()) {
                      if (postdate != DateTime(1, 1, 1, 1)) {
                        AuctionCubit.get(context)
                            .editPost(
                              category: dropdownValue.toString(),
                              startAuction: postdate,
                              description: _describtionController.text,
                              titel: _titleController.text,
                              price: int.parse(_priceController.text),
                            )
                            .whenComplete(() => Navigator.of(context).pop());
                      } else {
                        AuctionCubit.get(context)
                            .editPost(
                              category: dropdownValue.toString(),
                              startAuction: postmmm.startAuction,
                              description: _describtionController.text,
                              titel: _titleController.text,
                              price: int.parse(_priceController.text),
                            )
                            .whenComplete(() => Navigator.of(context).pop());
                      }
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      if (state is AuctionCreatePostLoadingState)
                        const LinearProgressIndicator(),
                      if (state is AuctionCreatePostLoadingState)
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
                              'Watches',
                              'Games',
                              'electonices',
                              'books',
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
                      // postImage != null
                      //     ? Stack(
                      //         children: [
                      //           SizedBox(
                      //             height: 200.0,
                      //             width: 200.0,
                      //             child: Container(
                      //               child: Image.file(
                      //                 postImage,
                      //                 fit: BoxFit.cover,
                      //               ),
                      //               //   AspectRatio(
                      //               // aspectRatio: 4 / 451,
                      //             ),
                      //           ),
                      //           Positioned(
                      //             top: 1,
                      //             right: 1,
                      //             child: IconButton(
                      //               onPressed: () {
                      //                 AuctionCubit.get(context)
                      //                     .removePostImage();
                      //               },
                      //               icon: const Icon(Icons.close_rounded,
                      //                   size: 25),
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //     : Stack(
                      //         children: [
                      //           Container(
                      //             width:
                      //                 MediaQuery.of(context).size.width * 0.99,
                      //             height: 200,
                      //             decoration: BoxDecoration(
                      //               image: DecorationImage(
                      //                 image: NetworkImage(
                      //                   '${post1['postImage']}',
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           Positioned(
                      //             top: 1,
                      //             right: 1,
                      //             child: IconButton(
                      //               onPressed: () {
                      //                 AuctionCubit.get(context).getPostImage();
                      //               },
                      //               icon: const Icon(Icons.close_rounded,
                      //                   size: 25),
                      //             ),
                      //           ),
                      //         ],
                      //       ),

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
                            // formatDate(
                            //     date, [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
                            setState(() {
                              postdate = date;
                            });
                          }, currentTime: DateTime.now());
                        },
                        child: postdate != DateTime(1, 1, 1, 1)
                            ? Text('$postdate',
                                style: TextStyle(color: Colors.blue))
                            : Text(
                                '${post1['postdate']}',
                                style: TextStyle(color: Colors.blue),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
