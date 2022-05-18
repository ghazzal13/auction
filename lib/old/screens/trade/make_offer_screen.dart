import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/nada/lib0/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

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
                          TextFormField(
                            controller: titleController,
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
                            controller: descriptionController,
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextFormField(
                              controller: priceController,
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
                          OfferImage != null
                              ? Stack(
                                  children: [
                                    SizedBox(
                                      height: 200.0,
                                      width: 200.0,
                                      child: Container(
                                        child: Image.file(
                                          OfferImage,
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
                                              .removeOfferImage();
                                        },
                                        icon: const Icon(Icons.close_rounded,
                                            size: 25),
                                      ),
                                    ),
                                  ],
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
                          const SizedBox(
                            width: 15,
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
                                    if (formKey.currentState!.validate()) {
                                      AuctionCubit.get(context)
                                          .uploadOfferImage(
                                              uid: tradeitem1['uid'],
                                              name: tradeitem1['name'],
                                              image: tradeitem1['image'],
                                              tradeItemImage:
                                                  tradeitem1['tradeItemImage'],
                                              titel: tradeitem1['titel'],
                                              description:
                                                  tradeitem1['description'],
                                              datePublished:
                                                  tradeitem1['datePublished'],
                                              offertitel: titleController.text,
                                              offerDescription:
                                                  descriptionController.text,
                                              offerprice: priceController.text,
                                              tradeItemId:
                                                  tradeitem1['tradeItemId'])
                                          .then((value) {
                                        Navigator.pop(context);

                                        AuctionCubit.get(context)
                                            .removeOfferImage();
                                      });
                                    }
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
