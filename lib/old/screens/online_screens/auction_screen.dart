import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/screens/online_screens/edit_post_Screen.dart';
import 'package:auction/old/screens/online_screens/online_auction_event_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../nada/lib0/search_screen.dart';
import '../../app_bar_screens/shopping_cart_screen.dart';
import '../../app_bar_screens/sort_screen.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({Key? key}) : super(key: key);

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  CollectionReference db = FirebaseFirestore.instance.collection('posts');
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
                'Auction',
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SortScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.sort_rounded),
                ),
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
                    .collection('posts')
                    .where('uid', isEqualTo: userModel.uid)
                    .where('endAuction', isGreaterThan: DateTime.now())
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
    'category': ''
  };

  Widget PostCard3({required dynamic snap, context, required String userid}) {
    return GestureDetector(
        onTap: () {
          AuctionCubit.get(context)
              .getComments(snap['postId'].toString(), 'posts');
          AuctionCubit.get(context)
              .getprice(snap['postId'].toString(), 'posts');
          AuctionCubit.get(context)
              .getPostById(id: snap['postId'])
              .then((value) {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            width: 5,
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
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
                                                        'posts',
                                                        snap['postId']
                                                            .toString());
                                                Navigator.pop(context, 'OK');
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (value.toString() == '/Edit') {
                                      AuctionCubit.get(context)
                                          .getPostById(id: snap['postId'])
                                          .then((value) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPostScreen(
                                                snap['postId'].toString(),
                                                post1: {
                                                  'name':
                                                      snap['name'].toString(),
                                                  'image':
                                                      snap['image'].toString(),
                                                  'postdate':
                                                      snap['postTime'].toDate(),
                                                  'titel':
                                                      snap['titel'].toString(),
                                                  'price':
                                                      snap['price'].toString(),
                                                  'description':
                                                      snap['description']
                                                          .toString(),
                                                  'category': snap['category']
                                                      .toString(),
                                                  'postImage': snap['postImage']
                                                      .toString(),
                                                },
                                                postId:
                                                    snap['postId'].toString(),
                                              ),
                                            ));
                                      });
                                    }
                                  },
                                  itemBuilder: (BuildContext bc) {
                                    return const [
                                      PopupMenuItem(
                                        child: Text("Delete"),
                                        value: '/Delete',
                                      ),
                                      PopupMenuItem(
                                        child: Text("Edit"),
                                        value: '/Edit',
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
                                                AuctionCubit.get(context)
                                                    .reportPost(
                                                        reportText:
                                                            _reportController
                                                                .text,
                                                        titel: snap['titel']
                                                            .toString(),
                                                        category:
                                                            snap['category']
                                                                .toString(),
                                                        description:
                                                            snap['description']
                                                                .toString(),
                                                        postTime:
                                                            snap['postTime']
                                                                .toDate(),
                                                        postUserimage:
                                                            snap['image'],
                                                        postUsername:
                                                            snap['name']
                                                                .toString(),
                                                        postUseruid:
                                                            snap['uid'],
                                                        startAuction:
                                                            snap['startAuction']
                                                                .toDate(),
                                                        price: snap['price'])
                                                    .then((value) =>
                                                        Navigator.pop(
                                                            context, 'Send'));
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Text(
                                  snap['titel'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.teal[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  DateFormat.yMMMd()
                                      .format(snap['startAuction'].toDate()),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
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
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // Container(
                              //   alignment: Alignment.topLeft,
                              //   child: Countdown(
                              //     seconds: (snap['startAuction'].toDate())!
                              //         .difference(DateTime.now())
                              //         .inSeconds,
                              //     build: (BuildContext context, double time) =>
                              //         Text(
                              //       '${Duration(seconds: time.toInt()).inDays.remainder(365).toString()}:${Duration(seconds: time.toInt()).inHours.remainder(24).toString()}:${Duration(seconds: time.toInt()).inMinutes.remainder(60).toString()}:${Duration(seconds: time.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                              //       style: TextStyle(
                              //         fontSize: 20,
                              //         color: Theme.of(context).primaryColor,
                              //       ),
                              //     ),
                              //     interval: Duration(seconds: 1),
                              //     onFinished: () {
                              //       print('Timer is done!');
                              //       AuctionCubit.get(context)
                              //           .updatePostState(isStarted: true);
                              //     },
                              //   ),
                              // ),
                              Text(
                                snap['category'].toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  // Text('${AuctionCubit.get(context).likes[index]}'),

                                  IconButton(
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
                                ],
                              ),
                            ],
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
/*
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
};
Widget PostCard({required dynamic snap, context, required String userid}) {
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
                doo = (snap['startAuction'].toDate())!
                    .difference(DateTime.now())
                    .inSeconds,
                duration: doo,
                post1: {
                  'name': snap['name'].toString(),
                  'titel': snap['titel'].toString(),
                  'postdate': snap['postTime'].toDate(),
                  'image': snap['image'].toString(),
                  'postImage': snap['image'].toString(),
                  'startAuction': snap['startAuction'].toDate(),
                },
              ),
            ),
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
                          DateFormat.yMMMd()
                              .format(snap['startAuction'].toDate()),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Countdown(
                          seconds: (snap['startAuction'].toDate())!
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
                            AuctionCubit.get(context)
                                .updatePostState(isStarted: true);
                            // Navigator.pop(context);
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
              snap['uid'].toString() == userid
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          useRootNavigator: false,
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: [
                                    'Delete',
                                  ]
                                      .map(
                                        (e) => InkWell(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Text(e),
                                            ),
                                            onTap: () {
                                              AuctionCubit.get(context)
                                                  .deletDoc(
                                                      'posts',
                                                      snap['postId']
                                                          .toString());

                                              // remove the dialog box
                                              Navigator.of(context).pop();
                                            }),
                                      )
                                      .toList()),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.more_vert),
                    )
                  : Container(),
            ],
          ),
        ),
      ));
}
*/