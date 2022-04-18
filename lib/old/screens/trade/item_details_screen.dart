import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/comment_model.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String tradeItemId;
  final int index;
  const ItemDetailsScreen(
    this.tradeItemId,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ItemDetailsScreen> createState() =>
      _ItemDetailsScreenState(tradeItemId: tradeItemId, index: index);
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final TextEditingController _cccController = TextEditingController();

  String tradeItemId;
  int index;

  _ItemDetailsScreenState({
    required this.tradeItemId,
    required this.index,
  });

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    AuctionCubit.get(context).comments1.length > 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AuctionCubit.get(context).model;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text('${AuctionCubit.get(context).TradeItems[index].titel}'),
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
                // if (state is AuctionGetCommentLoadingState)
                //   const LinearProgressIndicator(),
                // if (state is AuctionUserUpdateLoadingState)
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.teal,
                          backgroundImage: NetworkImage(
                              '${AuctionCubit.get(context).TradeItems[index].image}'),
                        ),
                      ),
                      Text(
                        '${AuctionCubit.get(context).TradeItems[index].name}',
                        style: TextStyle(
                          color: Colors.teal[600],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.99,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          '${AuctionCubit.get(context).TradeItems[index].tradeItemImage}'),
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
                              tradeItemId,
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
