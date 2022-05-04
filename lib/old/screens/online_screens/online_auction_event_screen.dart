import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/comment_model.dart';
import 'package:auction/old/resources/models/event_model.dart';
import 'package:auction/old/screens/online_screens/online_home_screen1.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

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
  void initState() {
    super.initState();
  }

  final TextEditingController _cccController = TextEditingController();

  String postId;
  Map post1;
  // int index;

  _OnlineEventScreenState({
    required this.postId,
    // required this.index,
    required this.duration,
    required this.post1,
  });

  // Future<int> _calculateSquare(int num) async {
  //   await Future.delayed(Duration(seconds: 0));
  //   return num * num;
  // }

  /////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = AuctionCubit.get(context).model;
          var postmmm = AuctionCubit.get(context).postByID;
          //  counter = postmmm[0].price!;
          // return Center(
          //     child: FutureBuilder<dynamic>(
          //   future: _calculateSquare(5),
          //   //  AuctionCubit.get(context).getPostById(id: postId),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
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
              child: post1['startAuction']!.isBefore(DateTime.now())
                  ? Column(
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.teal,
                                  backgroundImage:
                                      NetworkImage('${post1['image']}'),
                                ),
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
                        Countdown(
                          seconds: duration + 60 * 3 * 60,
                          build: (BuildContext context, double time) => Text(
                            '${Duration(seconds: time.toInt()).inHours.remainder(24).toString()}:${Duration(seconds: time.toInt()).inMinutes.remainder(60).toString()}:${Duration(seconds: time.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 50,
                              color: Colors.red,
                            ),
                          ),
                          interval: Duration(seconds: 1),
                          onFinished: () {
                            print('Timer is done!');

                            AuctionCubit.get(context)
                                .updatePostState(isFinish: true);
                            if (AuctionCubit.get(context)
                                .encreasePrices
                                .isNotEmpty) {
                              AuctionCubit.get(context).updatePostState(
                                  winner: AuctionCubit.get(context)
                                      .encreasePrices[0]
                                      .uid);
                            }

                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          height: 300,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(15.0),
                            itemBuilder: (context, x) => buildPricesItem(
                                AuctionCubit.get(context).encreasePrices[x]),
                            itemCount:
                                AuctionCubit.get(context).encreasePrices.length,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // AuctionCubit.get(context).updatePostPrice(
                            //     AuctionCubit.get(context)
                            //             .encreasePrices[0]
                            //             .price! +
                            //         100);

                            setState(() {
                              if (AuctionCubit.get(context)
                                  .encreasePrices
                                  .isNotEmpty) {
                                newPrice = AuctionCubit.get(context)
                                        .encreasePrices[0]
                                        .price! +
                                    100;
                              } else {
                                newPrice = postmmm.price!;
                              }
                              // AuctionCubit.get(context).getprice(
                              //     postId, 'posts',
                              //     id: postmmm.postId);
                              AuctionCubit.get(context).encreasePrice(
                                  'posts', postId,
                                  price: newPrice);
                              if (AuctionCubit.get(context)
                                  .encreasePrices
                                  .isNotEmpty) {
                                AuctionCubit.get(context).updatePostPrice(
                                    price: AuctionCubit.get(context)
                                            .encreasePrices[0]
                                            .price! +
                                        100,
                                    winner: userModel.uid);
                              } else {
                                AuctionCubit.get(context).updatePostPrice(
                                    price: postmmm.price,
                                    winner: userModel.uid);
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.teal,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'add 100',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(Icons.add, size: 30),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
                                    width: 5,
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
                                        '${post1['postdate']}',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Titel: ',
                                      style: TextStyle(
                                        fontSize: 20,
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
                                    const Text(
                                      'Category: ',
                                      style: TextStyle(
                                        fontSize: 20,
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
                                const SizedBox(
                                  height: 5,
                                ),
                                /*  Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    DateFormat.yMMMd()
                                        .format(post1['startAuction'].toDate()),
                                  ),
                                ),*/
                                const SizedBox(
                                  height: 5,
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
                            Countdown(
                              seconds: duration,
                              build: (BuildContext context, double time) =>
                                  Text(
                                '${Duration(seconds: time.toInt()).inDays.remainder(365).toString()}:${Duration(seconds: time.toInt()).inHours.remainder(24).toString()}:${Duration(seconds: time.toInt()).inMinutes.remainder(60).toString()}:${Duration(seconds: time.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: 50,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              interval: Duration(seconds: 1),
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
                            Container(
                              height: 200,
                              child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    buildCommentItem(
                                        AuctionCubit.get(context)
                                            .comments1[index],
                                        index),
                                itemCount:
                                    AuctionCubit.get(context).comments1.length,
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _cccController,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        hintText: 'comment',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        AuctionCubit.get(context).writeComment(
                                          'posts',
                                          postId,
                                          comment: _cccController.text,
                                        );
                                      },
                                      icon: const Icon(Icons.add_circle_sharp)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        }

        // return CircularProgressIndicator();
        //   },
        // ),
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
              padding: EdgeInsets.all(5.0),
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

class Countdownv extends AnimatedWidget {
  Countdownv({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inDays.remainder(60).toString()}:${clockTimer.inHours.remainder(60).toString()}:${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    // print('animation.value  ${animation.value} ');
    // print('inMinutes ${clockTimer.inMinutes.toString()}');
    // print('inSeconds ${clockTimer.inSeconds.toString()}');
    // print(
    //     'inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    if (clockTimer.inSeconds == 0) {
      //  AuctionCubit.get(context).updatePostState(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OnlineHome(),
        ),
      );
    }

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 50,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

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
              padding: EdgeInsets.all(5.0),
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
