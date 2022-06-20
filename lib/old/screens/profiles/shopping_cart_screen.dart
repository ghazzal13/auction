import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/screens/offline_screens/ticket_details_screen.dart';
import 'package:auction/old/screens/online_screens/edit_post_Screen.dart';
import 'package:auction/old/screens/online_screens/online_auction_event_screen.dart';
import 'package:auction/old/screens/online_screens/online_manage_screen.dart';
import 'package:auction/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';

import '../../../theme.dart';
import '../trade/item_details_screen.dart';
import 'charge_taxes_screen.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  CollectionReference db = FirebaseFirestore.instance.collection('posts');
  final TextEditingController _reportController = TextEditingController();

  final int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 4) {
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

  bool online = true;
  int feed = 0;
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
                'My Shopping Cart',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                PopupMenuButton(
                  onSelected: (value) {
                    if (value.toString() == '/Online Auction') {
                      setState(() {
                        feed = 0;
                      });
                    } else if (value.toString() == '/Offline Auction') {
                      setState(() {
                        feed = 1;
                      });
                    } else if (value.toString() == '/Trade Items') {
                      setState(() {
                        feed = 2;
                      });
                    }
                  },
                  itemBuilder: (BuildContext bc) {
                    return const [
                      PopupMenuItem(
                        child: Text("Online Auction"),
                        value: '/Online Auction',
                      ),
                      PopupMenuItem(
                        child: Text("Offline Auction"),
                        value: '/Offline Auction',
                      ),
                      PopupMenuItem(
                        child: Text("Trade Items"),
                        value: '/Trade Items',
                      ),
                    ];
                  },
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
              child: feed == 0
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .where('endAuction', isLessThan: DateTime.now())
                          .where('winnerID', isEqualTo: userModel.uid)
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
                            child: PostCard3(
                                context: context,
                                snap: snapshot.data!.docs[index].data(),
                                userid: userModel.uid.toString()),
                          ),
                        );
                      },
                    )
                  : (feed == 1)
                      ? StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('tickets')
                              .where('owner', arrayContains: userModel.uid)
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
                                child: PostCard4(
                                    context: context,
                                    snap: snapshot.data!.docs[index].data(),
                                    userid: userModel.uid.toString()),
                              ),
                            );
                          },
                        )
                      : StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('offers')
                              .where('winners', arrayContains: userModel.uid)
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
                                child: PostCard5(
                                    context: context,
                                    snap: snapshot.data!.docs[index].data(),
                                    userid: userModel.uid.toString()),
                              ),
                            );
                          },
                        ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  backgroundColor: primaryColor,
                  icon: Icon(Icons.menu),
                  label: 'Menu',
                ),
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
                'endAuction': snap['endAuction'].toDate(),
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
                                '${DateFormat.yMd().add_jm().format(snap['postTime'].toDate())} '),
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
                                        title: const Text('AlertDialog Title'),
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
                                                'name': snap['name'].toString(),
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
                                                'category':
                                                    snap['category'].toString(),
                                                'postImage': snap['postImage']
                                                    .toString(),
                                              },
                                              postId: snap['postId'].toString(),
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
                                            onPressed: () {},
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
                                    ' ${DateFormat.yMd().add_jm().format(snap['startAuction'].toDate())}  '),
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
                    snap['isFinish'] == false
                        ? TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChargeDetalis(
                                    colliction: 'posts',
                                    postId: snap['uid'].toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Charging Detalis',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(Icons.check_box_outline_blank),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Charging Now ',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.done_outline_rounded,
                                )
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int duration22 = 10;
  late int doo2;
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
                      duration: doo2,
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
                                                        postId: snap['ticketId']
                                                            .toString(),
                                                        postImage:
                                                            snap['ticketImage']
                                                                .toString(),
                                                        postUserimage:
                                                            snap['image']
                                                                .toString(),
                                                        postUsername: snap['name']
                                                            .toString(),
                                                        postUseruid: snap['uid']
                                                            .toString(),
                                                        reportType: 'offline',
                                                        startAuction:
                                                            snap['dateTime']
                                                                .toDate(),
                                                        address: snap['address']
                                                            .toString(),
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
                      snap['isFinish'] == false
                          ? TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ChargeDetalis(
                                      colliction: 'tickets',
                                      postId: snap['ticketId'].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'Charging Detalis',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(Icons.check_box_outline_blank),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Charging Now ',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(
                                    Icons.done_outline_rounded,
                                  )
                                ],
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget PostCard5({required dynamic snap, context, required String userid}) {
    return GestureDetector(
      onTap: () {
        AuctionCubit.get(context)
            .getComments(snap['tradeItemId'].toString(), 'tradeitem');

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemDetailsScreen(
                      snap['tradeItemId'].toString(),
                      tradeitem1: {
                        'name': snap['name'].toString(),
                        'uid': snap['uid'].toString(),
                        'titel': snap['titel'].toString(),
                        'image': snap['image'].toString(),
                        'tradeItemImage': snap['tradeItemImage'].toString(),
                        'description': snap['description'].toString(),
                        'datePublished': snap['datePublished'].toDate(),
                        'tradeItemId': snap['tradeItemId'].toString(),
                      })),
        );
      },
      child: (snap['offerUserID'].toString() == userid)
          ? Padding(
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
                  child: Column(
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
                                  '${DateFormat.yMd().add_jm().format(snap['datePublished'].toDate())} '),
                            ],
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
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.52,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    snap['tradeItemImage'].toString(),
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      snap['isFinish'] == false
                          ? TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ChargeDetalis(
                                      colliction: 'offers',
                                      postId: snap['offerId'].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'Charging Detalis',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(Icons.check_box_outline_blank),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Charging Now ',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(
                                    Icons.done_outline_rounded,
                                  )
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            )
          : Padding(
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
                  child: Column(
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
                                  snap['offerUserImage'].toString(),
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
                                snap['offerUsername'].toString(),
                                style: TextStyle(
                                  color: Colors.teal[600],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                  '${DateFormat.yMd().add_jm().format(snap['datePublished'].toDate())} '),
                            ],
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
                                      snap['offertitel'].toString(),
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
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: Text(
                                    snap['offerDescription'].toString(),
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
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.52,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    snap['offerImage'].toString(),
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      snap['isFinish'] == false
                          ? TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ChargeDetalis(
                                      colliction: 'offers',
                                      postId: snap['offerId'].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'Charging Detalis',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(Icons.check_box_outline_blank),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Charging Now ',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(
                                    Icons.done_outline_rounded,
                                  )
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
}
