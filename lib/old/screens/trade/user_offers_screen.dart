import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/nada/lib0/theme.dart';
import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/screens/trade/item_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

class UserOffersScreen extends StatefulWidget {
  const UserOffersScreen({Key? key}) : super(key: key);

  @override
  State<UserOffersScreen> createState() => _UserOffersScreenState();
}

final TextEditingController _reportController = TextEditingController();

class _UserOffersScreenState extends State<UserOffersScreen> {
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
              'My Items',
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
                  .collection('offers')
                  .where('uid', isEqualTo: userModel.uid)
                  .where('isEnd', isEqualTo: false)
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
                    child: PostCard6(
                      context: context,
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

Widget PostCard6({required dynamic snap, context}) {
  return Padding(
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
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
                              // Text(
                              //   DateFormat.yMMMd()
                              //       .format(snap['datePublished']!.toDate()),
                              // ),
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
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 140,
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
                ),
              ),
              Center(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 130,
                    ),
                    Icon(Icons.repeat_outlined),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
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
                                  snap['offerUserImage'].toString(),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                snap['offerUsername'].toString(),
                                style: TextStyle(
                                  color: Colors.teal[600],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // Text(
                              //   DateFormat.yMMMd()
                              //       .format(snap['datePublished']!.toDate()),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Container(
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //     snap['offertitel'].toString(),
                      //     style: TextStyle(
                      //       fontSize: 15,
                      //       color: Colors.teal[600],
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          snap['offerprice'].toString(),
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
                          snap['offerDescription'].toString(),
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
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 140,
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
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      AuctionCubit.get(context).cancelOffer(
                          uid: snap['uid'].toString(),
                          name: snap['name'].toString(),
                          image: snap['image'].toString(),
                          tradeItemImage: snap['tradeItemImage'].toString(),
                          titel: snap['titel'].toString(),
                          description: snap['description'].toString(),
                          offertitel: snap['offertitel'].toString(),
                          offerDescription: snap['offerDescription'].toString(),
                          offerprice: snap['offerprice'].toString(),
                          tradeItemId: snap['tradeItemId'].toString(),
                          offerID: snap['offerId'].toString(),
                          offerImage: snap['offerImage'].toString());
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      print(snap['uid'].toString());
                      print(snap['offerId'].toString());
                      AuctionCubit.get(context).acceptOffer(
                          uid: snap['uid'].toString(),
                          name: snap['name'].toString(),
                          image: snap['image'].toString(),
                          tradeItemImage: snap['tradeItemImage'].toString(),
                          titel: snap['titel'].toString(),
                          description: snap['description'].toString(),
                          offertitel: snap['offertitel'].toString(),
                          offerDescription: snap['offerDescription'].toString(),
                          offerprice: snap['offerprice'].toString(),
                          tradeItemId: snap['tradeItemId'].toString(),
                          offerID: snap['offerId'].toString(),
                          offerImage: snap['offerImage'].toString());
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'accept',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
            
            /*
             StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('tradeitem')
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
                      child: PostCard5(
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
  late Map tradeitem1 = {
    'name': '',
    'titel': '',
    'image': '',
    'category': '',
    'description': '',
    'tradeItemImage': '',
    'datePublished': '',
    'tradeItemId': '',
    'uid': '',
  };
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
                                      content:
                                          const Text('AlertDialog description'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
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
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              keyboardType: TextInputType.text,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
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
                      Container(
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
                  
                ],
              ),
            ),
          ),
        ));
  }
}

          
*/