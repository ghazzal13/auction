import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/ticket.dart';
import 'package:auction/old/screens/offline_screens/ticket_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../app_bar_screens/shopping_cart_screen.dart';
import '../../resources/reuse_component.dart';

class OfflineHomeScreen extends StatefulWidget {
  const OfflineHomeScreen({Key? key}) : super(key: key);

  @override
  State<OfflineHomeScreen> createState() => _OfflineHomeScreenState();
}

class _OfflineHomeScreenState extends State<OfflineHomeScreen> {
  final TextEditingController _reportController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = AuctionCubit.get(context).model;
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
                        userid: userModel.uid.toString(),
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
  Widget PostCard4({required dynamic snap, context, required String userid}) {
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
                        'datePublished': snap['datePublished'],
                        'dateTime': snap['dateTime'],
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                          const SizedBox(
                            width: 10,
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
                                DateFormat.yMd()
                                    .add_jm()
                                    .format(snap['datePublished']!.toDate()),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.32,
                          ),
                          snap['uid'].toString() == userid
                              ? PopupMenuButton(
                                  onSelected: (value) {
                                    if (value.toString() == '/Delete') {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title:
                                              const Text('AlertDialog Title'),
                                          content: const Text(
                                              'AlertDialog description'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                AuctionCubit.get(context)
                                                    .deletDoc(
                                                        'tickets',
                                                        snap['ticketId']
                                                            .toString());
                                                Navigator.pop(context, 'OK');
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext bc) {
                                    return const [
                                      PopupMenuItem(
                                        child: Text("Delete"),
                                        value: '/Delete',
                                      ),
                                    ];
                                  },
                                )
                              : PopupMenuButton(
                                  onSelected: (value) {
                                    if (value.toString() == '/Report') {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Report Post'),
                                          content: SizedBox(
                                            height: 160,
                                            child: Column(
                                              children: [
                                                const Text(
                                                    ' What is the  problem on with this post?'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  maxLines: 5,
                                                  minLines: 4,
                                                  controller: _reportController,
                                                  validator: ValidationBuilder()
                                                      .minLength(50)
                                                      .maxLength(250)
                                                      .build(),
                                                  decoration: InputDecoration(
                                                    hintText: '....',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, 'Send');
                                              },
                                              child: const Text('Send'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext bc) {
                                    return const [
                                      PopupMenuItem(
                                        child: Text("Report"),
                                        value: '/Report',
                                      ),
                                    ];
                                  },
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  snap['titel'].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[600],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  snap['address'].toString(),
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
                                  DateFormat.yMd()
                                      .add_jm()
                                      .format(snap['dateTime']!.toDate()),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Text(
                                  snap['description'].toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.teal[600],
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Countdown(
                                seconds: (snap['dateTime'].toDate())!
                                    .difference(DateTime.now())
                                    .inSeconds,
                                build: (BuildContext context, double time) =>
                                    Text(
                                  '${Duration(seconds: time.toInt()).inDays.remainder(365).toString()}:${Duration(seconds: time.toInt()).inHours.remainder(24).toString()}:${Duration(seconds: time.toInt()).inMinutes.remainder(60).toString()}:${Duration(seconds: time.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                interval: const Duration(seconds: 1),
                                onFinished: () {
                                  print('Timer is done!');
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    snap['ticketImage'].toString(),
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
