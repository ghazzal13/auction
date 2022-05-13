import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/nada/lib0/search_screen.dart';
import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/screens/online_screens/edit_post_Screen.dart';
import 'package:auction/old/screens/online_screens/online_auction_event_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

class MyReportsScreen extends StatefulWidget {
  const MyReportsScreen({Key? key}) : super(key: key);

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> {
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
                'Reports on my item',
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
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
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
                    .collection('report')
                    .where('postUseruid', isEqualTo: userModel.uid)
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
                      child: PostCard3(
                          context: context,
                          snap: snapshot.data!.docs[index].data(),
                          userid: userModel.uid.toString()),
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
  late PostModel SelectedPost;
  late Map post1 = {
    'name': '',
    'titel': '',
    'postdate': '',
    'image': '',
    'postImage': '',
    'isStarted': '',
    'category': '',
    'token': ''
  };

  Widget PostCard3({required dynamic snap, context, required String userid}) {
    return GestureDetector(
        onTap: () {
          AuctionCubit.get(context).getPostUserTocken(
            snap['uid'].toString(),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnlineEventScreen(
                snap['postId'].toString(),
                doo = (snap['startAuction'].toDate())!
                    .difference(DateTime.now())
                    .inSeconds,
                duration: doo,
                post1: {
                  'name': snap['name'].toString(),
                  'uid': snap['uid'].toString(),
                  'titel': snap['titel'].toString(),
                  'postdate': snap['postTime'].toDate(),
                  'image': snap['image'].toString(),
                  'postImage': snap['image'].toString(),
                  'startAuction': snap['startAuction'].toDate(),
                  'price': snap['price'].toString(),
                  'description': snap['description'].toString(),
                  'category': snap['category'].toString(),
                },
              ),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snap['titel'].toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.teal[600],
                                        fontWeight: FontWeight.bold,
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
                                      ' ${DateFormat.yMd().add_jm().format(snap['startAuction'].toDate())}  '),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
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
                                snap['winner'].toString() != "null"
                                    ? Text(
                                        snap['winner'].toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : const Text(
                                        'no One play in this item',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                // DateTime.now()
                                //         .isAfter(snap['startAuction'].toDate())
                                //     ? Container(
                                //         alignment: Alignment.topLeft,
                                //         child: Countdown(
                                //           seconds:
                                //               (snap['endAuction'].toDate())!
                                //                   .difference(DateTime.now())
                                //                   .inSeconds,
                                //           build: (BuildContext context,
                                //                   double time) =>
                                //               Text(
                                //             '${Duration(seconds: time.toInt()).inHours.remainder(24).toString()}:${Duration(seconds: time.toInt()).inMinutes.remainder(60).toString()}:${Duration(seconds: time.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                //             style: const TextStyle(
                                //               fontSize: 30,
                                //               color: Colors.red,
                                //             ),
                                //           ),
                                //           interval: Duration(seconds: 1),
                                //           onFinished: () {
                                //             print('Timer is done!');
                                //             AuctionCubit.get(context)
                                //                 .updatePostState(
                                //                     isFinish: true);
                                //           },
                                //         ),
                                //       )
                                //     : Container(
                                //         alignment: Alignment.topLeft,
                                //         child: Countdown(
                                //           seconds:
                                //               (snap['endAuction'].toDate())!
                                //                   .difference(DateTime.now())
                                //                   .inSeconds,
                                //           build: (BuildContext context,
                                //                   double time) =>
                                //               Text(
                                //             '${Duration(seconds: time.toInt()).inDays.remainder(365).toString()}:${Duration(seconds: time.toInt()).inHours.remainder(24).toString()}:${Duration(seconds: time.toInt()).inMinutes.remainder(60).toString()}:${Duration(seconds: time.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                //             style: TextStyle(
                                //               fontSize: 25,
                                //               color: Theme.of(context)
                                //                   .primaryColor,
                                //             ),
                                //           ),
                                //           interval: Duration(seconds: 1),
                                //           onFinished: () {
                                //             print('Timer is done!');
                                //             AuctionCubit.get(context)
                                //                 .updatePostState(
                                //                     isStarted: true);
                                //           },
                                //         ),
                                //       ),
                                Text(
                                  snap['category'].toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.52,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    snap['postImage'].toString(),
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
