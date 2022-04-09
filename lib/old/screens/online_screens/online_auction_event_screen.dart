import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/comment_model.dart';
import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnlineEventScreen extends StatefulWidget {
  final String postId;
  final int index;
  const OnlineEventScreen(
    this.postId,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<OnlineEventScreen> createState() =>
      _OnlineEventScreenState(postId: postId, index: index);
}

class _OnlineEventScreenState extends State<OnlineEventScreen> {
  final TextEditingController _cccController = TextEditingController();

  String postId;
  int index;

  _OnlineEventScreenState({
    required this.postId,
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
              title: Text('${AuctionCubit.get(context).posts[index].titel}')),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                                    '${AuctionCubit.get(context).posts[index].image}'),
                              ),
                            ),
                            Text(
                              '${AuctionCubit.get(context).posts[index].name}',
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
                                '${AuctionCubit.get(context).posts[index].postImage}'),
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(15.0),
                          itemBuilder: (context, index) => buildCommentItem(
                              AuctionCubit.get(context).comments1[index],
                              index),
                          itemCount: AuctionCubit.get(context).comments1.length,
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _cccController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'comment',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),

                            // TextField(
                            //             decoration: InputDecoration(
                            //               border: OutlineInputBorder(),
                            //               hintText: 'Enter a search term',
                            //             ),
                            //           ),

                            // TextFieldInput(
                            //     textEditingController: _cccController,
                            //     hintText: 'comment',
                            //     textInputType: TextInputType.text),
                            const SizedBox(
                              height: 20,
                            ),
                            IconButton(
                                onPressed: () {
                                  AuctionCubit.get(context).writeComment(postId,
                                      comment: _cccController.text);
                                },
                                icon: const Icon(Icons.add_circle_sharp)),
                          ],
                        ),
                      ),
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

// Widget buildPost(PostModel postmodel, context) => Container(
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: Colors.teal.withOpacity(0.2),
//       ),
//       child: Row(
//         children: [
//           Column(
//             children: [
//               Row(
//                 children: [
//                   Stack(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: CircleAvatar(
//                           radius: 30,
//                           backgroundColor: Colors.teal,
//                           backgroundImage: NetworkImage('${postmodel.image}'),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     '${postmodel.name}',
//                     style: TextStyle(
//                       color: Colors.teal[600],
//                       fontSize: 17,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               // Container(
//               //   height: 200,
//               //   child: ListView.builder(
//               //     padding: const EdgeInsets.all(15.0),
//               //     itemBuilder: (context, index) => buildComment(
//               //         AuctionCubit.get(context).comments[index],
//               //         context,
//               //         index),
//               //     itemCount: AuctionCubit.get(context).comments.length,
//               //   ),
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );

Widget buildCommentItem(CommentModel commentModel, index) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.teal.withOpacity(0.2),
      ),
      height: 50,
      width: 300,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.teal,
              backgroundImage: NetworkImage('${commentModel.image}'),
            ),
          ),
          Column(
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
        ],
      ),
    );
