import 'package:auction/cubit/cubit.dart';
import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/screens/online_screens/auction_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'online_auction_event_screen.dart';

class NotificationScreeen extends StatefulWidget {
  const NotificationScreeen({Key? key}) : super(key: key);

  @override
  State<NotificationScreeen> createState() => _NotificationScreeenState();
}

class _NotificationScreeenState extends State<NotificationScreeen> {
  CollectionReference db = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('notificatoin'),
    ));
  }
}
      /*
       StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('isFinish', isEqualTo: false)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
              ),
            ),
          );
        },
      ),
    );
  }
}

int duration = 10;
late int doo;
late PostModel SelectedPost;
Widget PostCard3({required dynamic snap, context}) {
  return GestureDetector(
      onTap: () {
        AuctionCubit.get(context)
            .getComments(snap['postId'].toString(), 'posts');
        AuctionCubit.get(context).getprice(snap['postId'].toString(), 'posts');
        AuctionCubit.get(context).getPostById(id: snap['postId']).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnlineEventScreen(
                snap['postId'].toString(),
                doo = (snap['dateTime'].toDate())!
                    .difference(snap['postTime'].toDate())
                    .inSeconds,
                duration: doo,
              ),
            ),
            // MaterialPageRoute(
            //   builder: (context) => AuctionScreen(
            //     snap['postId'].toString(),
            //     // doo = (snap['postTime'].toDate())!
            //     //     .difference(DateTime.now())
            //     //     .inSeconds,
            //     // duration: doo,
            //   ),
            // ),
          );
        });
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
                                    .format(snap['postTime'].toDate()),
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
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          DateFormat.yMMMd().format(snap['dateTime'].toDate()),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Countdown(
                          seconds: (snap['dateTime'].toDate())!
                              .difference(snap['postTime'].toDate())
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
                                  snap['postImage'].toString(),
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                          width: 5,
                        ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
}
*/