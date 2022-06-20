import 'dart:math';

import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/comment_model.dart';
import 'package:auction/old/screens/trade/make_offer_screen.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String tradeItemId;

  final Map tradeitem1;
  const ItemDetailsScreen(
    this.tradeItemId, {
    Key? key,
    required this.tradeitem1,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState(
        tradeItemId: tradeItemId,
        tradeitem1: tradeitem1,
      );
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final TextEditingController _cccController = TextEditingController();

  String tradeItemId;

  _ItemDetailsScreenState({
    required this.tradeItemId,
    required this.tradeitem1,
  });

  var _expandedComment = false;
  Map tradeitem1;
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();

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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.teal,
                              backgroundImage:
                                  NetworkImage('${tradeitem1['image']}'),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                '${tradeitem1['name']}',
                                style: TextStyle(
                                  color: Colors.teal[600],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${DateFormat.yMd().add_jm().format(tradeitem1['datePublished'])} ',
                                style: TextStyle(
                                  color: Colors.teal[600],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage('${tradeitem1['tradeItemImage']}'),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Titel: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${tradeitem1['titel']}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Description: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        '${tradeitem1['description']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.teal[600],
                          fontWeight: FontWeight.w600,
                        ),
                        // maxLines: 5,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ListTile(
                      title: const Text('Comments'),
                      subtitle: (AuctionCubit.get(context).comments1.isNotEmpty)
                          ? Text(
                              'There is ${AuctionCubit.get(context).comments1.length} comments')
                          : const Text('There is no comments'),
                      trailing: IconButton(
                        icon: Icon(_expandedComment
                            ? Icons.expand_less
                            : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            _expandedComment = !_expandedComment;
                          });
                        },
                      ),
                    ),
                    if (_expandedComment)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        height: min(
                            AuctionCubit.get(context).comments1.length * 50.0 +
                                10,
                            200),
                        child: ListView.builder(
                          itemBuilder: (context, index) => buildCommentItem(
                              AuctionCubit.get(context).comments1[index],
                              index),
                          itemCount: AuctionCubit.get(context).comments1.length,
                        ),
                      ),
                    const SizedBox(height: 15),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: _cccController,
                          validator: ValidationBuilder(
                                  requiredMessage: 'cant be empty')
                              .maxLength(50)
                              .build(),
                          decoration: InputDecoration(
                              hintText: '  write comment... ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: const EdgeInsets.all(5),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AuctionCubit.get(context)
                                        .writeComment(
                                      'tradeitem',
                                      tradeitem1['tradeItemId'],
                                      comment: _cccController.text,
                                    )
                                        .then((value) {
                                      _cccController.clear();
                                    });
                                  }
                                },
                                icon: const Icon(Icons.send),
                              )),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    tradeitem1['uid'] != userModel.uid
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton.extended(
                                onPressed: () {
                                  // when clicked on floating action button prompt to create user
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MakeOfferScreem(tradeitem1: {
                                              'name': tradeitem1['name'],
                                              'uid': tradeitem1['uid'],
                                              'titel': tradeitem1['titel'],
                                              'image': tradeitem1['image'],
                                              'tradeItemImage':
                                                  tradeitem1['tradeItemImage'],
                                              'description':
                                                  tradeitem1['description'],
                                              'tradeItemId':
                                                  tradeitem1['tradeItemId'],
                                              'datePublished':
                                                  tradeitem1['datePublished'],
                                            })),
                                  );
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Make An Offer'),
                              ),
                            ],
                          )
                        : Container()
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

Widget buildCommentItem(CommentModel commentModel, index) => Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.teal.withOpacity(0.2),
        ),
        height: 50,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.teal,
                backgroundImage: NetworkImage('${commentModel.image}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${commentModel.name}',
                    style: TextStyle(
                      color: Colors.teal[600],
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('${commentModel.comment}')
                ],
              ),
            ),
          ],
        ),
      ),
    );
