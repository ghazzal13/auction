import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/resources/reuse_component.dart';
import 'package:auction/old/screens/online_screens/online_auction_event_screen.dart';
import 'package:auction/old/screens/search_screen.dart';
import 'package:auction/old/screens/shopping_cart_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OnlineHome extends StatefulWidget {
  const OnlineHome({Key? key}) : super(key: key);

  @override
  State<OnlineHome> createState() => _OnlineHomeState();
}

class _OnlineHomeState extends State<OnlineHome> {
  CollectionReference db = FirebaseFirestore.instance.collection('posts');

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
  late PostModel SelectedPost;
  Widget PostCard3({required dynamic snap, context}) {
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
}
        
        
        
        /* Scaffold(
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
            // child:
            child: ConditionalBuilder(
              condition: state is! AuctionGetPostLoadingState,
              // condition: AuctionCubit.get(context).posts.isNotEmpty,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                    AuctionCubit.get(context).posts[index],
                    context,
                    index,
                  ),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: AuctionCubit.get(context).posts.length,
                ),
              ),
              fallback: (context) => const Center(
                  child: CircularProgressIndicator(color: Colors.red)),
            ),
          ),
        );
      },
    );
  }
}

int duration = 10;
late int doo;

Widget buildPostItem(PostModel postmodel, context, index) => GestureDetector(
    onTap: () {
      // AuctionCubit.get(context).getComments(postmodel.postId, 'posts');
      // AuctionCubit.get(context).getprice(postmodel.postId, 'posts');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OnlineEventScreen(
      // AuctionCubit.get(context).postId[index],
      //       index,
      //       doo = postmodel.dateTime!.difference(DateTime.now()).inSeconds,
      //       duration: doo,
      //     ),
      //   ),
      // );
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
                              backgroundImage:
                                  NetworkImage('${postmodel.image}'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${postmodel.name}',
                              style: TextStyle(
                                color: Colors.teal[600],
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${postmodel.postTime}',
                              style: TextStyle(
                                color: Colors.teal[600],
                                fontSize: 8,
                              ),
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
                        '${postmodel.titel}',
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
                        '${postmodel.dateTime}',
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
                        Text('${AuctionCubit.get(context).likes[index]}'),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          child: IconButton(
                            onPressed: () {
                              AuctionCubit.get(context).likePost(
                                  AuctionCubit.get(context).postId[index]);
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
                              image: NetworkImage('${postmodel.postImage}'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                        width: 5,
                      ),
                      Text(
                        '${postmodel.category}',
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

//          FutureBuilder(
//         future:postsss.get(),
//         builder: (ctx, snapshot) =>
//         snapshot.connectionState == ConnectionState.waiting
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//                   padding: const EdgeInsets.all(15.0),
//                   itemBuilder: (context, index) =>

//                 builder: (ctx, productsData, _) => Padding(

//                       padding: EdgeInsets.all(8),
//                       child: ListView.builder(
//                         itemCount: productsData.items.length,
//                         itemBuilder: (_, i) => Column(
//                               children: [
//                                 UserProductItem(
//                                   productsData.items[i].id,
//                                   productsData.items[i].title,
//                                   productsData.items[i].imageUrl,
//                                 ),
//                                 Divider(),
//                               ],
//                             ),
//                       ),
//                     ),
//               ),
//             ),
// ),

// FutureBuilder(
//     future: AuctionCubit.get(context).getPosts(),
//     builder: (BuildContext context,
//      AsyncSnapshot<List<PostModel>> snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       } else {
//         return ListView.builder(
//           padding: const EdgeInsets.all(15.0),
//           itemBuilder: (context, index) => buildPostItem(
//               snapshot[index], context, index),
//           itemCount: snapshot.data!.length,
//         );
//       }
//     })

// child: FutureBuilder(
//                   future: postsss.get(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     } else {
//                       return ListView.builder(
//                         padding: const EdgeInsets.all(15.0),
//                         itemBuilder: (context, index) => buildPostItem(
//                             snapshot.data!.docs[index].data(), context, index),
//                         itemCount: snapshot.data!.size,
//                       );
//                     }
//                   })



*/