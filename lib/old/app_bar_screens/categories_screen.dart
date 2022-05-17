import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/screens/online_screens/edit_post_Screen.dart';
import 'package:auction/old/screens/online_screens/online_manage_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../theme.dart';
import '../screens/online_screens/online_auction_event_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  get color => Colors.black;
  final TextEditingController _reportController = TextEditingController();

  late bool select;
  @override
  void initState() {
    select = false;
    super.initState();
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

  var category;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = AuctionCubit.get(context).model;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: const Text(
                'Categories',
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
              child: select == false
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Categories')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (ctx, index) => Container(
                            child: CategoreCard(
                                context: context,
                                snap: snapshot.data!.docs[index].data(),
                                userid: userModel.uid.toString()),
                          ),
                        );
                      },
                    )
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .where('endAuction', isGreaterThan: DateTime.now())
                          .where('category', isEqualTo: category)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (ctx, index) => Container(
                              child: PostCard3(
                                  context: context,
                                  snap: snapshot.data!.docs[index].data(),
                                  userid: userModel.uid.toString()),
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text('sorry no have any items'),
                          );
                        }
                        return const Center(
                          child: Text('sorry we have a problem'),
                        );
                      },
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

  Widget CategoreCard(
      {required dynamic snap, context, required String userid}) {
    return InkWell(
      onTap: () {
        setState(() {
          select = true;
        });
        category = snap['title'].toString();
        print(
          snap['title'].toString(),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    snap['image'].toString(),
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      snap['title'].toString(),
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  '${DateFormat.yMMMd().format(snap['postTime'].toDate())} --  ${DateFormat.Hm().format(snap['postTime'].toDate())}'),
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
                                                        description:
                                                            snap['description']
                                                                .toString(),
                                                        datePublished:
                                                            snap['datePublished']
                                                                .toDate(),
                                                        postImage:
                                                            snap['postImage']
                                                                .toString(),
                                                        postUserimage:
                                                            snap['image']
                                                                .toString(),
                                                        postUsername:
                                                            snap['name']
                                                                .toString(),
                                                        postUseruid:
                                                            snap['uid'],
                                                        reportType: 'offline',
                                                        startAuction:
                                                            snap['dateTime']
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
                                      ' ${DateFormat.yMMMd().format(snap['startAuction'].toDate())} --  ${DateFormat.Hm().format(snap['startAuction'].toDate())} '),
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
                                DateTime.now()
                                        .isAfter(snap['startAuction'].toDate())
                                    ? Container(
                                        alignment: Alignment.topLeft,
                                        child: Countdown(
                                          seconds:
                                              (snap['endAuction'].toDate())!
                                                  .difference(DateTime.now())
                                                  .inSeconds,
                                          build: (BuildContext context,
                                                  double time) =>
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
                                                .updatePostState(
                                                    isFinish: true);
                                          },
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.topLeft,
                                        child: Countdown(
                                          seconds:
                                              (snap['endAuction'].toDate())!
                                                  .difference(DateTime.now())
                                                  .inSeconds,
                                          build: (BuildContext context,
                                                  double time) =>
                                              Text(
                                            '${Duration(seconds: time.toInt()).inDays.remainder(365).toString()}:${Duration(seconds: time.toInt()).inHours.remainder(24).toString()}:${Duration(seconds: time.toInt()).inMinutes.remainder(60).toString()}:${Duration(seconds: time.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          interval: const Duration(seconds: 1),
                                          onFinished: () {
                                            print('Timer is done!');
                                            AuctionCubit.get(context)
                                                .updatePostState(
                                                    isStarted: true);
                                          },
                                        ),
                                      ),
                                Text(
                                  snap['category'].toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     TextButton.icon(
                                //         onPressed: () {},
                                //         icon: const Icon(
                                //           Icons.gpp_good,
                                //           color: Colors.black,
                                //           size: 15,
                                //         ),
                                //         label: const Text(
                                //           '10',
                                //           style: TextStyle(
                                //             fontSize: 15,
                                //             color: Colors.teal,
                                //             fontWeight: FontWeight.w600,
                                //           ),
                                //         )),
                                //     TextButton.icon(
                                //         onPressed: () {},
                                //         icon: const Icon(
                                //           Icons.comment,
                                //           color: Colors.black,
                                //           size: 15,
                                //         ),
                                //         label: const Text(
                                //           '0100',
                                //           style: TextStyle(
                                //             fontSize: 15,
                                //             color: Colors.teal,
                                //             fontWeight: FontWeight.w600,
                                //           ),
                                //         ))
                                //   ],
                                // )
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
