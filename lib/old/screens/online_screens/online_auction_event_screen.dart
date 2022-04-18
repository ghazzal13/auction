import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/comment_model.dart';
import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/resources/text_field_input.dart';
import 'package:auction/old/screens/online_screens/online_home_screen1.dart';
import 'package:auction/theme.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OnlineEventScreen extends StatefulWidget {
  final String postId;
  final int index;
  final int duration;
  const OnlineEventScreen(
    this.postId,
    this.index,
    int i, {
    Key? key,
    required this.duration,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<OnlineEventScreen> createState() =>
      _OnlineEventScreenState(postId: postId, index: index, duration: duration);
}

class _OnlineEventScreenState extends State<OnlineEventScreen>
    with TickerProviderStateMixin {
  // late AnimationController _controller;

  late DateTime v;
  late DateTime b;
  // int levelClock = 50;
  // bool isStarted = false;
  var duration;

  // // int levelClock = v.difference(b).inSeconds;
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();

    setState(() {
      v = AuctionCubit.get(context).posts[index].postTime!;
      b = AuctionCubit.get(context).posts[index].dateTime!;
      int d = b.difference(v).inSeconds;
      print(d);
    });
  }
  //   _controller = AnimationController(
  //       vsync: this,
  //       duration: Duration(
  //           seconds:
  //               duration) // gameData.levelClock is a user entered number elsewhere in the applciation
  //       );

  //   _controller.forward();
  // }

  final TextEditingController _cccController = TextEditingController();

  String postId;
  int index;

  _OnlineEventScreenState({
    required this.postId,
    required this.index,
    required this.duration,
  });

  /////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AuctionCubit.get(context).model;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text('${AuctionCubit.get(context).posts[index].titel}'),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/222.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: AuctionCubit.get(context).posts[index].isStarted!
                ? Container(
                    width: 500,
                    height: 500,
                    decoration: const BoxDecoration(color: Colors.black),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // if (state is AuctionGetCommentLoadingState)
                        //   const LinearProgressIndicator(),
                        // if (state is AuctionUserUpdateLoadingState)
                        SizedBox(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.teal,
                                  backgroundImage: NetworkImage(
                                      '${AuctionCubit.get(context).posts[index].image}'),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${AuctionCubit.get(context).posts[index].name}',
                                    style: TextStyle(
                                      color: Colors.teal[600],
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${AuctionCubit.get(context).posts[index].postTime}',
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
                        Container(
                          width: MediaQuery.of(context).size.width * 0.99,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${AuctionCubit.get(context).posts[index].postImage}'),
                            ),
                          ),
                        ),
                        Container(
                          height: 300,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(15.0),
                            itemBuilder: (context, index) => buildCommentItem(
                                AuctionCubit.get(context).comments1[index],
                                index),
                            itemCount:
                                AuctionCubit.get(context).comments1.length,
                          ),
                        ),
                        // Countdown(
                        //   animation: StepTween(
                        //     begin: duration, // THIS IS A USER ENTERED NUMBER
                        //     end: 0,
                        //   ).animate(_controller),
                        // ),
                        Countdown(
                          seconds: duration,
                          build: (BuildContext context, double time) => Text(
                            '${Duration(seconds: time.toInt()).inDays.remainder(60).toString()}:${Duration(seconds: time.toInt()).inHours.remainder(60).toString()}:${Duration(seconds: time.toInt()).inMinutes.remainder(60).toString()}:${Duration(seconds: time.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 50,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          interval: Duration(seconds: 1),
                          onFinished: () {
                            print('Timer is done!');
                            AuctionCubit.get(context).updatePostState(index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OnlineHome(),
                              ),
                            );
                          },
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
