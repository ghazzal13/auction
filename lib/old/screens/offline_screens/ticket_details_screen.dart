import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/comment_model.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_count_down/timer_count_down.dart';

class TicketDetailsScreen extends StatefulWidget {
  final String ticketId;
  final int duration;
  final Map ticket1;

  const TicketDetailsScreen(
    this.ticketId,
    int i, {
    Key? key,
    required this.ticket1,
    required this.duration,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState(
        ticketId: ticketId,
        duration: duration,
        ticket1: ticket1,
      );
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  final TextEditingController _cccController = TextEditingController();

  String ticketId;
  Map ticket1;
  int duration;

  _TicketDetailsScreenState({
    required this.ticketId,
    required this.ticket1,
    required this.duration,
  });

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    AuctionCubit.get(context).comments1.length > 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AuctionCubit.get(context).model;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text('${ticket1['titel']}'),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/222.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.teal,
                          backgroundImage: NetworkImage('${ticket1['image']}'),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '${ticket1['name']}',
                            style: TextStyle(
                              color: Colors.teal[600],
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${ticket1['datePublished']}',
                            style: TextStyle(
                              color: Colors.teal[600],
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
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
                      image: NetworkImage('${ticket1['ticketImage']}'),
                    ),
                  ),
                ),
                Countdown(
                  seconds: duration,
                  build: (BuildContext context, double time) => Text(
                    '${Duration(seconds: time.toInt()).inDays.remainder(365).toString()}:${Duration(seconds: time.toInt()).inHours.remainder(24).toString()}:${Duration(seconds: time.toInt()).inMinutes.remainder(60).toString()}:${Duration(seconds: time.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  interval: Duration(seconds: 1),
                  onFinished: () {
                    print('Timer is done!');
                    // AuctionCubit.get(context)
                    //     .updatePostState(isStarted: true);

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
                  height: 300,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15.0),
                    itemBuilder: (context, index) => buildCommentItem(
                        AuctionCubit.get(context).comments1[index], index),
                    itemCount: AuctionCubit.get(context).comments1.length,
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
                              'tickets',
                              ticketId,
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
          floatingActionButton: FloatingActionButton(
              onPressed: () {}, child: const Text('Buy Ticket')),
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
