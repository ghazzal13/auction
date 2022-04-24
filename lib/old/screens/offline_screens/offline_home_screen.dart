import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/ticket.dart';
import 'package:auction/old/screens/offline_screens/ticket_details_screen.dart';
import 'package:auction/old/screens/shopping_cart_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../resources/reuse_component.dart';

class OfflineHomeScreen extends StatefulWidget {
  const OfflineHomeScreen({Key? key}) : super(key: key);

  @override
  State<OfflineHomeScreen> createState() => _OfflineHomeScreenState();
}

class _OfflineHomeScreenState extends State<OfflineHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.teal,
              title: const Text(
                'Tickets',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShoppingCartScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/222.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('tickets')
                    .where('dateTime', isGreaterThan: DateTime.now())
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) => Container(
                      child: PostCard4(
                        context: context,
                        snap: snapshot.data!.docs[index].data(),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }

  int duration = 10;
  late int doo;
  late Map ticket1 = {
    'name': '',
    'titel': '',
    'image': '',
    'category': '',
    'address': '',
    'description': '',
    'datePublished': '',
    'ticketId': '',
    'ticketImage': '',
    'dateTime': '',
  };
  Widget PostCard4({required dynamic snap, context}) {
    return GestureDetector(
        onTap: () {
          AuctionCubit.get(context)
              .getComments(snap['ticketId'].toString(), 'tickets');

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TicketDetailsScreen(
                      snap['ticketId'].toString(),
                      doo = (snap['dateTime'].toDate())!
                          .difference(DateTime.now())
                          .inSeconds,
                      ticket1: {
                        'name': snap['name'].toString(),
                        'titel': snap['titel'].toString(),
                        'image': snap['image'].toString(),
                        'ticketImage': snap['ticketImage'].toString(),
                        'description': snap['description'].toString(),
                        'address': snap['address'].toString(),
                        'datePublished': snap['datePublished'].toDate(),
                        'dateTime': snap['dateTime'].toDate(),
                        'ticketId': snap['ticketId'].toString(),
                      },
                      duration: doo,
                    )),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 5,
            top: 5,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.teal.withOpacity(0.2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.teal,
                                  backgroundImage: NetworkImage(
                                    snap['image'].toString(),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  snap['name'].toString(),
                                  style: TextStyle(
                                    color: Colors.teal[600],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMd()
                                      .format(snap['datePublished']!.toDate()),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            snap['titel'].toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.teal[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Countdown(
                          seconds: (snap['dateTime'].toDate())!
                              .difference(DateTime.now())
                              .inSeconds,
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
                            // Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => OnlineHome(),
                            //   ),
                            // );
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            // Text('${AuctionCubit.get(context).likes[index]}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              child: IconButton(
                                onPressed: () {
                                  // AuctionCubit.get(context).likePost(
                                  //     AuctionCubit.get(context).postId[index]);
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 7,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 140,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    snap['tradeItemImage'].toString(),
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                            width: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
            
            
            
            
          /*  ConditionalBuilder(
              condition: state is! AuctionGetTicketLoadingState,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildTicketItem(
                      AuctionCubit.get(context).ticket[index], context, index),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: AuctionCubit.get(context).ticket.length,
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}

Widget buildTicketItem(TicketModel ticketmodel, context, index) =>
    GestureDetector(
        onTap: () {
          AuctionCubit.get(context)
              .getComments(ticketmodel.ticketId, 'tickets');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketDetailsScreen(
                  AuctionCubit.get(context).ticketId[index], index),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 5,
            top: 5,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.teal.withOpacity(0.2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.teal,
                                  backgroundImage:
                                      NetworkImage('${ticketmodel.image}'),
                                ),
                              ],
                            ),
                            Text(
                              '${ticketmodel.name}',
                              style: TextStyle(
                                color: Colors.teal[600],
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${ticketmodel.titel}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.teal[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${ticketmodel.dateTime}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.teal[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '4 Days - 12 Hours',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.teal[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                                '${AuctionCubit.get(context).ticketLikes[index]}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 7,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 140,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${ticketmodel.ticketImage}'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                            width: 5,
                          ),
                          Text(
                            '${ticketmodel.category}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.teal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
*/