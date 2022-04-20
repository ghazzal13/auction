import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/comment_model.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String tradeItemId;

  final Map tradeitem1;
  const ItemDetailsScreen(
    this.tradeItemId, {
    Key? key,
    required this.tradeitem1,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState(
        tradeItemId: tradeItemId,
        tradeitem1: tradeitem1,
      );
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final TextEditingController _cccController = TextEditingController();

  String tradeItemId;

  _ItemDetailsScreenState({
    required this.tradeItemId,
    required this.tradeitem1,
  });

  Map tradeitem1;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AuctionCubit.get(context).model;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text('${tradeitem1['titel']}'),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/222.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.teal,
                          backgroundImage:
                              NetworkImage('${tradeitem1['image']}'),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '${tradeitem1['name']}',
                            style: TextStyle(
                              color: Colors.teal[600],
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${tradeitem1['datePublished']}',
                            style: TextStyle(
                              color: Colors.teal[600],
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.99,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${tradeitem1['tradeItemImage']}'),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15.0),
                    itemBuilder: (context, index) => buildCommentItem(
                        AuctionCubit.get(context).comments1[index], index),
                    itemCount: AuctionCubit.get(context).comments1.length,
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _cccController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'comment',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            AuctionCubit.get(context).writeComment(
                              'tradeitem',
                              tradeitem1['tradeItemId'],
                              comment: _cccController.text,
                            );
                          },
                          icon: const Icon(Icons.add_circle_sharp)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildCommentItem(CommentModel commentModel, index) => Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.teal.withOpacity(0.2),
        ),
        height: 50,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.teal,
                backgroundImage: NetworkImage('${commentModel.image}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${commentModel.name}',
                    style: TextStyle(
                      color: Colors.teal[600],
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('${commentModel.comment}')
                ],
              ),
            ),
          ],
        ),
      ),
    );
