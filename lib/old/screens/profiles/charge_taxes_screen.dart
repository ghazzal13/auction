import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../theme.dart';
import '../online_screens/online_manage_screen.dart';

class ChargeDetalis extends StatefulWidget {
  final String postId;
  final String colliction;
  const ChargeDetalis(
      {Key? key, required this.postId, required this.colliction})
      : super(key: key);

  @override
  State<ChargeDetalis> createState() => _ChargeDetalisState(
        postId: postId,
        colliction: colliction,
      );
}

class _ChargeDetalisState extends State<ChargeDetalis> {
  late final TextEditingController _cityAddressController =
      TextEditingController();
  late final TextEditingController _MohafzaController = TextEditingController();
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _phonenumberController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    try {
      _cityAddressController.dispose();
      _MohafzaController.dispose();
      _phonenumberController.dispose();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  String postId;
  String colliction;

  _ChargeDetalisState({
    required this.postId,
    required this.colliction,
  });

  final int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 4) {
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
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text(
                'Charge Detalis',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.teal,
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
                      TextFormField(
                        controller: _nameController,
                        validator: ValidationBuilder(
                                requiredMessage: 'name must not be empty')
                            .minLength(4)
                            .maxLength(50)
                            .build(),
                        decoration: InputDecoration(
                          hintText: ' name of reciver ',
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
                        controller: _phonenumberController,
                        validator: ValidationBuilder(
                                requiredMessage: 'Phone must not be empty')
                            .phone()
                            .build(),
                        decoration: InputDecoration(
                          hintText: ' Phone Number ',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextFormField(
                              controller: _cityAddressController,
                              validator: ValidationBuilder(
                                      requiredMessage:
                                          'address must not be empty')
                                  .maxLength(100)
                                  .build(),
                              decoration: InputDecoration(
                                hintText: ' address ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: const EdgeInsets.all(8),
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextFormField(
                              controller: _MohafzaController,
                              validator: ValidationBuilder(
                                      requiredMessage:
                                          'mohafza must not be empty')
                                  .maxLength(100)
                                  .build(),
                              decoration: InputDecoration(
                                hintText: ' mohafza ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: const EdgeInsets.all(8),
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            AuctionCubit.get(context).acceptChargePost(
                                postId: postId, colection: colliction);
                            _MohafzaController.clear();
                            _nameController.clear();
                            _phonenumberController.clear();
                            Navigator.of(context).pop();
                          }
                        },
                        backgroundColor: Colors.teal,
                        label: const Text(
                          "submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ],
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
        });
  }
}
