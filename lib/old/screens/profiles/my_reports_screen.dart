import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/screens/online_screens/online_manage_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../theme.dart';

class MyReportsScreen extends StatefulWidget {
  const MyReportsScreen({Key? key}) : super(key: key);

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> {
  final int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 3) {
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
                'Reports',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/222.jpg"),
              )),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('report')
                    .where('postUseruid', isEqualTo: userModel.uid)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print('ConnectionState is waiting');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    print('ConnectionState is has data');
                  }
                  if (snapshot.hasError) {
                    print('ConnectionState is has error');
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) => Container(
                      child: reportCard(
                        context: context,
                        snap: snapshot.data!.docs[index].data(),
                      ),
                    ),
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
}

Widget reportCard({required dynamic snap, context}) {
  if (snap['reportType'].toString() == 'online') {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
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
                        radius: 30,
                        backgroundColor: Colors.teal,
                        backgroundImage: NetworkImage(
                          snap['postUserimage'].toString(),
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
                        snap['postUsername'].toString(),
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
                  const Spacer(),
                  PopupMenuButton(
                    onSelected: (value) {
                      if (value.toString() == '/delete') {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Delete User"),
                            content: const Text(
                                "Are you sure you want to Delete This User?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'NO'),
                                child: const Text('NO'),
                              ),
                              TextButton(
                                onPressed: () {
                                  AuctionCubit.get(context).deletDoc(
                                      'users', snap['postUseruid'].toString());
                                  Navigator.pop(context, 'YES');
                                },
                                child: const Text('YES'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext bc) {
                      return const [
                        PopupMenuItem(
                          child: Text("delete"),
                          value: '/delete',
                        ),
                      ];
                    },
                  ),
                ],
              ),
              Column(
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
                  Text(
                    snap['category'].toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    snap['price'].toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        snap['postImage'].toString(),
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                ' Rrport :',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 30,
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
                          const Spacer(),
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value.toString() == '/delete') {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text("Delete User"),
                                    content: const Text(
                                        "Are you sure you want to Delete This User?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'NO'),
                                        child: const Text('NO'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          AuctionCubit.get(context).deletDoc(
                                              'users', snap['uid'].toString());
                                          Navigator.pop(context, 'YES');
                                        },
                                        child: const Text('YES'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            itemBuilder: (BuildContext bc) {
                              return const [
                                PopupMenuItem(
                                  child: Text("delete"),
                                  value: '/delete',
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: Text(
                            snap['reportText'].toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.teal[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  if (snap['reportType'].toString() == 'offline') {
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
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
                        radius: 30,
                        backgroundColor: Colors.teal,
                        backgroundImage: NetworkImage(
                          snap['postUserimage'].toString(),
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
                        snap['postUsername'].toString(),
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
                  const Spacer(),
                  PopupMenuButton(
                    onSelected: (value) {
                      if (value.toString() == '/delete') {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Delete User"),
                            content: const Text(
                                "Are you sure you want to Delete This User?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'NO'),
                                child: const Text('NO'),
                              ),
                              TextButton(
                                onPressed: () {
                                  AuctionCubit.get(context).deletDoc(
                                      'users', snap['postUseruid'].toString());
                                  Navigator.pop(context, 'YES');
                                },
                                child: const Text('YES'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext bc) {
                      return const [
                        PopupMenuItem(
                          child: Text("delete"),
                          value: '/delete',
                        ),
                      ];
                    },
                  ),
                ],
              ),
              Column(
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
                      Text(
                        snap['address'].toString(),
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
                  // Container(
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //       ' ${DateFormat.yMd().add_jm().format(snap['startAuction'].toDate())}  '),
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
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
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        snap['ticketImage'].toString(),
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                ' Rrport: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 30,
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
                          const Spacer(),
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value.toString() == '/delete') {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text("Delete User"),
                                    content: const Text(
                                        "Are you sure you want to Delete This User?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'NO'),
                                        child: const Text('NO'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          AuctionCubit.get(context).deletDoc(
                                              'users', snap['uid'].toString());
                                          Navigator.pop(context, 'YES');
                                        },
                                        child: const Text('YES'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            itemBuilder: (BuildContext bc) {
                              return const [
                                PopupMenuItem(
                                  child: Text("delete"),
                                  value: '/delete',
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: Text(
                            snap['reportText'].toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.teal[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  if (snap['reportType'].toString() == 'trade') {
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
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
                        radius: 30,
                        backgroundColor: Colors.teal,
                        backgroundImage: NetworkImage(
                          snap['postUserimage'].toString(),
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
                        snap['postUsername'].toString(),
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
                  const Spacer(),
                  PopupMenuButton(
                    onSelected: (value) {
                      if (value.toString() == '/delete') {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Delete User"),
                            content: const Text(
                                "Are you sure you want to Delete This User?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'NO'),
                                child: const Text('NO'),
                              ),
                              TextButton(
                                onPressed: () {
                                  AuctionCubit.get(context).deletDoc(
                                      'users', snap['postUseruid'].toString());
                                  Navigator.pop(context, 'YES');
                                },
                                child: const Text('YES'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext bc) {
                      return const [
                        PopupMenuItem(
                          child: Text("delete"),
                          value: '/delete',
                        ),
                      ];
                    },
                  ),
                ],
              ),
              Column(
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
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        snap['tradeItemImage'].toString(),
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                ' Rrport: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 30,
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
                          const Spacer(),
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value.toString() == '/delete') {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text("Delete User"),
                                    content: const Text(
                                        "Are you sure you want to Delete This User?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'NO'),
                                        child: const Text('NO'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          AuctionCubit.get(context).deletDoc(
                                              'users', snap['uid'].toString());
                                          Navigator.pop(context, 'YES');
                                        },
                                        child: const Text('YES'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            itemBuilder: (BuildContext bc) {
                              return const [
                                PopupMenuItem(
                                  child: Text("delete"),
                                  value: '/delete',
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: Text(
                            snap['reportText'].toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.teal[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  if (snap['reportType'].toString() == 'comment') {}
  return Container();
}
