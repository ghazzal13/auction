import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/nada/lib0/theme.dart';
import 'package:auction/old/resources/reuse_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeOfferScreem extends StatefulWidget {
  final Map tradeitem1;
  const MakeOfferScreem({Key? key, required this.tradeitem1}) : super(key: key);

  @override
  State<MakeOfferScreem> createState() => _MakeOfferScreemState(
        tradeitem1: tradeitem1,
      );
}

class _MakeOfferScreemState extends State<MakeOfferScreem> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  bool isBottomSheetShown = true;

  _MakeOfferScreemState({required this.tradeitem1});

  Map tradeitem1;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = AuctionCubit.get(context).model;

          var OfferImage = AuctionCubit.get(context).OfferImage;
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: primaryColor,
                title: Text('${tradeitem1['titel']}'),
              ),
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/222.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(
                    20.0,
                  ),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (state is AuctionMakeAnOfferLoadingState)
                            const LinearProgressIndicator(),
                          if (state is AuctionMakeAnOfferLoadingState)
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
                            label: 'Title',
                            prefix: Icons.title,
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
                            label: 'description',
                            prefix: Icons.description,
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
                              label: 'price',
                              prefix: Icons.money),
                          const SizedBox(
                            height: 15.0,
                          ),
                          OfferImage != null
                              ? SizedBox(
                                  height: 200.0,
                                  width: 200.0,
                                  child: Container(
                                    child: Image.file(
                                      OfferImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {
                                    AuctionCubit.get(context).getofferImage();
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.photo_library_outlined),
                                      Text(
                                        'addPhoto',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      AuctionCubit.get(context)
                                          .removeOfferImage();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Cancel'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    AuctionCubit.get(context).uploadOfferImage(
                                        uid: tradeitem1['uid'],
                                        name: tradeitem1['name'],
                                        image: tradeitem1['image'],
                                        tradeItemImage:
                                            tradeitem1['tradeItemImage'],
                                        titel: tradeitem1['titel'],
                                        description: tradeitem1['description'],
                                        datePublished:
                                            tradeitem1['datePublished'],
                                        offertitel: titleController.text,
                                        offerDescription:
                                            descriptionController.text,
                                        offerprice: priceController.text,
                                        tradeItemId: tradeitem1['tradeItemId']);
                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      Navigator.pop(context);
                                    });
                                    Future.delayed(const Duration(seconds: 15),
                                        () {
                                      AuctionCubit.get(context)
                                          .removeOfferImage();
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Offer'),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
