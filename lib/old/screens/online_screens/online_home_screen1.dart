import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/resources/reuse_component.dart';
import 'package:auction/old/screens/online_screens/online_auction_event_screen.dart';
import 'package:auction/old/resources/text_field_input.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';

class OnlineHome extends StatefulWidget {
  const OnlineHome({Key? key}) : super(key: key);

  @override
  State<OnlineHome> createState() => _OnlineHomeState();
}

class _OnlineHomeState extends State<OnlineHome> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    AuctionCubit.get(context).posts.length > 0;
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
              'Auction',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {},
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
            child: ConditionalBuilder(
              condition: state is! AuctionGetPostLoadingState,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                      AuctionCubit.get(context).posts[index], context, index),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: AuctionCubit.get(context).posts.length,
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
        );

        // ConditionalBuilder(
        //   condition: state is AuctionGetPostSuccessState,
        //   builder: (context) => SingleChildScrollView(
        //     physics: const BouncingScrollPhysics(),
        //     child: Column(
        //       children: [
        //         ListView.separated(
        //           shrinkWrap: true,
        //           physics: const NeverScrollableScrollPhysics(),
        //           itemBuilder: (context, index) => buildPostItem(
        //               AuctionCubit.get(context).posts[index], context, index),
        //           separatorBuilder: (context, index) => const SizedBox(
        //             height: 8.0,
        //           ),
        //           itemCount: AuctionCubit.get(context).posts.length,
        //         ),
        //         const SizedBox(
        //           height: 8.0,
        //         ),
        //       ],
        //     ),
        //   ),
        //   fallback: (context) =>
        //       const Center(child: CircularProgressIndicator()),
        // );

        // Container(
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/222.jpg"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   child: ListView.builder(
        //     padding: const EdgeInsets.all(15.0),
        //     itemBuilder: (context, index) => buildPostItem(
        //         AuctionCubit.get(context).posts[index], context, index),
        //     itemCount: AuctionCubit.get(context).posts.length,
        //   ),
        // );
      },
    );
  }
}

Widget buildPostItem(PostModel postmodel, context, index) => GestureDetector(
    onTap: () {
      AuctionCubit.get(context).getComments(postmodel.postId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OnlineEventScreen(AuctionCubit.get(context).postId[index], index),
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
                        Text(
                          '${postmodel.name}',
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
