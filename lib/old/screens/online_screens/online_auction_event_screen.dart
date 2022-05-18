import 'dart:convert';
import 'dart:math';

import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/comment_model.dart';
import 'package:auction/old/resources/models/event_model.dart';
import 'package:auction/old/screens/online_screens/add_post_screeen.dart';
import 'package:auction/old/screens/online_screens/auction_screen.dart';
import 'package:auction/old/screens/online_screens/online_home_screen1.dart';
import 'package:auction/old/screens/online_screens/online_manage_screen.dart';
import 'package:auction/old/screens/profiles/user_profile_screen.dart';
import 'package:auction/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:http/http.dart' as http;

class OnlineEventScreen extends StatefulWidget {
  final String postId;
  final Map post1;
  final int duration;
  const OnlineEventScreen(
    this.postId,
    // this.index,
    int i, {
    Key? key,
    required this.duration,
    required this.post1,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<OnlineEventScreen> createState() => _OnlineEventScreenState(
      postId: postId,
      post1: post1,
      //  index: index,
      duration: duration);
}

class _OnlineEventScreenState extends State<OnlineEventScreen>
    with TickerProviderStateMixin {
  // late AnimationController _controller;

  late DateTime v;
  late DateTime b;
  late int newPrice;
  var duration;

  @override
  final TextEditingController _cccController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String postId;
  Map post1;
  _OnlineEventScreenState({
    required this.postId,
    // required this.index,
    required this.duration,
    required this.post1,
  });
  sendNotification(
      {required String title,
      required String body,
      required String userId,
      required String token}) async {
    Random random = Random();
    int id = random.nextInt(1000);
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': id,
      'status': 'done',
      'message': title,
    };
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA_taaElA:APA91bFxaKqEC5HY4x9cwc3VXzJBQbk2LJOHSg1HqjemArliSKTMiV6J9NUV2OPN_n6YFI1UBkPp2Dghd3rSuyTUeoi9hNencecJJieY2x5L4vEnkNs-sC7aTDReMkCu70TseF2Qo-Ia'
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
            },
            'priority': 'high',
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': id,
              'status': 'done',
              'message': title,
            },
            'to': token
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Yeh notificatin is sended");
      } else {
        print("Error");
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    AuctionCubit.get(context).getPostById(id: postId);
    AuctionCubit.get(context).getComments(postId, 'posts');
    AuctionCubit.get(context).getprice(postId, 'posts');
  }

  final int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 0) {
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

  static const List<Widget> _widgetOptions = <Widget>[
    OnlineHome(),
    AuctionScreen(),
    AddPostScreeen(),
    ProfileScreen()
  ];

  var _expandedComment = false;
  var _expandedPrices = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = AuctionCubit.get(context).model;
          var postmmm = AuctionCubit.get(context).postByID;
          String token = AuctionCubit.get(context).postToken;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              // title: Text('${postmmm.titel}'),
              title: Text('${post1['titel']}'),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/222.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: formKey,
                child: post1['startAuction']!.isBefore(DateTime.now())
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.teal,
                                      backgroundImage:
                                          NetworkImage('${post1['image']}'),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '${post1['name']}',
                                          style: TextStyle(
                                            color: Colors.teal[600],
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '${DateFormat.yMd().add_jm().format(post1['postdate'])} ',
                                          // '${post1['postdate']}',
                                          style: TextStyle(
                                            color: Colors.teal[600],
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //
                              Container(
                                width: MediaQuery.of(context).size.width * 0.99,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('${postmmm.postImage}'),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
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
                                        '${post1['titel']}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.teal[600],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Category: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${post1['category']}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Price: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${postmmm.price}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    'Description:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      '${post1['description']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.teal[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                      // maxLines: 5,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'remaning time:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Countdown(
                                    seconds: duration + 60 * 3 * 60,
                                    build:
                                        (BuildContext context, double time) =>
                                            Text(
                                      '${Duration(seconds: time.toInt()).inHours.remainder(24).toString()}:${Duration(seconds: time.toInt()).inMinutes.remainder(60).toString()}:${Duration(seconds: time.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.red,
                                      ),
                                    ),
                                    interval: const Duration(seconds: 1),
                                    onFinished: () {
                                      print('Timer is done!');

                                      AuctionCubit.get(context)
                                          .updatePostState(isFinish: true);
                                      // if (AuctionCubit.get(context)
                                      //     .encreasePrices
                                      //     .isNotEmpty) {
                                      //   AuctionCubit.get(context)
                                      //       .updatePostState(
                                      //           winner:
                                      //               AuctionCubit.get(context)
                                      //                   .encreasePrices[0]
                                      //                   .uid);
                                      // }
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                              post1['uid'] == userModel.uid
                                  ? Column(
                                      children: [
                                        ListTile(
                                          title: const Text('Comments'),
                                          subtitle: (AuctionCubit.get(context)
                                                  .comments1
                                                  .isNotEmpty)
                                              ? Text(
                                                  'There is ${AuctionCubit.get(context).comments1.length} comments')
                                              : const Text(
                                                  'There is no comments'),
                                          trailing: IconButton(
                                            icon: Icon(_expandedComment
                                                ? Icons.expand_less
                                                : Icons.expand_more),
                                            onPressed: () {
                                              setState(() {
                                                _expandedComment =
                                                    !_expandedComment;
                                              });
                                            },
                                          ),
                                        ),
                                        if (_expandedComment)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 4),
                                            height: min(
                                                AuctionCubit.get(context)
                                                            .comments1
                                                            .length *
                                                        50.0 +
                                                    10,
                                                200),
                                            child: ListView.builder(
                                              itemBuilder: (context, index) =>
                                                  buildCommentItem(
                                                      AuctionCubit.get(context)
                                                          .comments1[index],
                                                      index),
                                              itemCount:
                                                  AuctionCubit.get(context)
                                                      .comments1
                                                      .length,
                                            ),
                                          ),
                                      ],
                                    )
                                  : Container(),
                              ListTile(
                                title: const Text('Operations'),
                                subtitle: (AuctionCubit.get(context)
                                        .encreasePrices
                                        .isNotEmpty)
                                    ? Text(
                                        'There is ${AuctionCubit.get(context).encreasePrices.length} operation')
                                    : const Text('There is no operation'),
                                trailing: IconButton(
                                  icon: Icon(_expandedPrices
                                      ? Icons.expand_less
                                      : Icons.expand_more),
                                  onPressed: () {
                                    setState(() {
                                      _expandedPrices = !_expandedPrices;
                                    });
                                  },
                                ),
                              ),
                              if (_expandedPrices)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 4),
                                  height: min(
                                      AuctionCubit.get(context)
                                                  .encreasePrices
                                                  .length *
                                              50.0 +
                                          10,
                                      200),
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(15.0),
                                    itemBuilder: (context, x) =>
                                        buildPricesItem(
                                            AuctionCubit.get(context)
                                                .encreasePrices[x]),
                                    itemCount: AuctionCubit.get(context)
                                        .encreasePrices
                                        .length,
                                  ),
                                ),
                              // Container(
                              //   height: 200,
                              //   child: ListView.builder(
                              //     padding: const EdgeInsets.all(15.0),
                              //     itemBuilder: (context, x) => buildPricesItem(
                              //         AuctionCubit.get(context)
                              //             .encreasePrices[x]),
                              //     itemCount: AuctionCubit.get(context)
                              //         .encreasePrices
                              //         .length,
                              //   ),
                              // ),
                              post1['uid'] != userModel.uid
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.39,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: TextFormField(
                                              controller: _priceController,
                                              validator: ValidationBuilder(
                                                      requiredMessage:
                                                          'cant be empty')
                                                  .maxLength(50)
                                                  .add((value) {
                                                if (int.parse(value!) <
                                                    AuctionCubit.get(context)
                                                        .encreasePrices[0]
                                                        .price!) {
                                                  return "can't be less";
                                                }
                                                return null;
                                              }).build(),
                                              decoration: InputDecoration(
                                                labelText: 'Price... ',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(12),
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      var temp =
                                                          _priceController;
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        AuctionCubit.get(
                                                                context)
                                                            .encreasePrice(
                                                              'posts',
                                                              postId,
                                                              price: int.parse(
                                                                  _priceController
                                                                      .text),
                                                            )
                                                            .then((value) =>
                                                                _priceController
                                                                    .clear());
                                                        if (AuctionCubit.get(
                                                                context)
                                                            .encreasePrices
                                                            .isNotEmpty) {
                                                          AuctionCubit
                                                                  .get(context)
                                                              .updatePostPrice(
                                                                  price: int
                                                                      .parse(temp
                                                                          .text),
                                                                  winner:
                                                                      userModel
                                                                          .name,
                                                                  winnerID:
                                                                      userModel
                                                                          .uid);
                                                        } else {
                                                          AuctionCubit.get(
                                                                  context)
                                                              .updatePostPrice(
                                                                  price: int
                                                                      .parse(temp
                                                                          .text),
                                                                  winnerID:
                                                                      userModel
                                                                          .uid,
                                                                  winner:
                                                                      userModel
                                                                          .name);
                                                        }
                                                      }
                                                    });
                                                    AuctionCubit.get(context)
                                                        .followPost(
                                                            postId,
                                                            userModel.uid
                                                                .toString());
                                                  },
                                                  icon: const Icon(Icons.send),
                                                ),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.done,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (AuctionCubit.get(context)
                                                  .encreasePrices
                                                  .isNotEmpty) {
                                                newPrice =
                                                    AuctionCubit.get(context)
                                                            .encreasePrices[0]
                                                            .price! +
                                                        100;
                                              } else {
                                                newPrice = postmmm.price!;
                                              }
                                              AuctionCubit.get(context)
                                                  .encreasePrice(
                                                      'posts', postId,
                                                      price: newPrice);
                                              if (AuctionCubit.get(context)
                                                  .encreasePrices
                                                  .isNotEmpty) {
                                                AuctionCubit.get(context)
                                                    .updatePostPrice(
                                                        price: AuctionCubit.get(
                                                                    context)
                                                                .encreasePrices[
                                                                    0]
                                                                .price! +
                                                            100,
                                                        winner: userModel.name,
                                                        winnerID:
                                                            userModel.uid);
                                              } else {
                                                AuctionCubit.get(context)
                                                    .updatePostPrice(
                                                        price: postmmm.price,
                                                        winnerID: userModel.uid,
                                                        winner: userModel.name);
                                              }
                                            });
                                            AuctionCubit.get(context)
                                                .followPost(postId,
                                                    userModel.uid.toString());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.teal,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                    'add 100',
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Icon(Icons.add, size: 30),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.teal,
                                      backgroundImage:
                                          NetworkImage('${post1['image']}'),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${post1['name']}',
                                          style: TextStyle(
                                            color: Colors.teal[600],
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '${DateFormat.yMd().add_jm().format(post1['postdate'])} ',
                                          style: TextStyle(
                                            color: Colors.teal[600],
                                            fontSize: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.99,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('${postmmm.postImage}'),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
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
                                        '${post1['titel']}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.teal[600],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Category: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${post1['category']}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Price: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${post1['price']}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    'Description:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      '${post1['description']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.teal[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                      // maxLines: 5,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'remaning time:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Countdown(
                                    seconds: duration,
                                    build:
                                        (BuildContext context, double time) =>
                                            Text(
                                      '${Duration(seconds: time.toInt()).inDays.remainder(365).toString()}:${Duration(seconds: time.toInt()).inHours.remainder(24).toString()}:${Duration(seconds: time.toInt()).inMinutes.remainder(60).toString()}:${Duration(seconds: time.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    interval: const Duration(seconds: 1),
                                    onFinished: () {
                                      print('Timer is done!');
                                      AuctionCubit.get(context)
                                          .updatePostState(isStarted: true);
                                      Navigator.pop(context);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => OnlineHome(),
                                      //   ),
                                      // );
                                    },
                                  ),
                                ],
                              ),
                              ListTile(
                                title: const Text('Comments'),
                                subtitle: (AuctionCubit.get(context)
                                        .comments1
                                        .isNotEmpty)
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
                                      AuctionCubit.get(context)
                                                  .comments1
                                                  .length *
                                              50.0 +
                                          10,
                                      200),
                                  child: ListView.builder(
                                    itemBuilder: (context, index) =>
                                        buildCommentItem(
                                            AuctionCubit.get(context)
                                                .comments1[index],
                                            index),
                                    itemCount: AuctionCubit.get(context)
                                        .comments1
                                        .length,
                                  ),
                                ),
                              // Container(
                              //   height: 200,
                              //   child: ListView.builder(
                              //     itemBuilder: (context, index) =>
                              //         buildCommentItem(
                              //             AuctionCubit.get(context)
                              //                 .comments1[index],
                              //             index),
                              //     itemCount: AuctionCubit.get(context)
                              //         .comments1
                              //         .length,
                              //   ),
                              // ),
                              Padding(
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
                                          if (formKey.currentState!
                                              .validate()) {
                                            AuctionCubit.get(context)
                                                .writeComment(
                                              'posts',
                                              postId,
                                              comment: _cccController.text,
                                            )
                                                .then((value) {
                                              _cccController.clear();
                                            });
                                            if (post1['uid'] != userModel.uid) {
                                              AuctionCubit.get(context)
                                                  .followPost(postId,
                                                      userModel.uid.toString());
                                            }
                                          }
                                        },
                                        icon: const Icon(Icons.send),
                                      )),
                                  keyboardType: TextInputType.text,
                                  onFieldSubmitted: (_) {
                                    if (formKey.currentState!.validate()) {
                                      AuctionCubit.get(context)
                                          .writeComment(
                                        'posts',
                                        postId,
                                        comment: _cccController.text,
                                      )
                                          .then((value) {
                                        _cccController.clear();
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
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

Widget buildPricesItem(EventModel eventModel) => Padding(
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
                backgroundImage: NetworkImage('${eventModel.image}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${eventModel.name}',
                    style: TextStyle(
                      color: Colors.teal[600],
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('${eventModel.price}')
                ],
              ),
            ),
          ],
        ),
      ),
    );
