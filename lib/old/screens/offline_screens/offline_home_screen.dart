import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/ticket.dart';
import 'package:auction/old/screens/offline_screens/ticket_details_screen.dart';
import 'package:auction/old/screens/shopping_cart_screen.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/reuse_component.dart';

class OfflineHomeScreen extends StatefulWidget {
  const OfflineHomeScreen({Key? key}) : super(key: key);

  @override
  State<OfflineHomeScreen> createState() => _OfflineHomeScreenState();
}

class _OfflineHomeScreenState extends State<OfflineHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.teal,
            title: const Text(
              'Tickets',
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
              condition: state is! AuctionGetTicketLoadingState,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildTicketItem(
                      AuctionCubit.get(context).ticket[index], context, index),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: AuctionCubit.get(context).ticket.length,
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}

Widget buildTicketItem(TicketModel ticketmodel, context, index) =>
    GestureDetector(
        onTap: () {
          AuctionCubit.get(context)
              .getComments(ticketmodel.ticketId, 'tickets');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketDetailsScreen(
                  AuctionCubit.get(context).ticketId[index], index),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.teal,
                                  backgroundImage:
                                      NetworkImage('${ticketmodel.image}'),
                                ),
                              ],
                            ),
                            Text(
                              '${ticketmodel.name}',
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
                            '${ticketmodel.titel}',
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
                            '${ticketmodel.dateTime}',
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
                            Text(
                                '${AuctionCubit.get(context).ticketLikes[index]}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              child: IconButton(
                                onPressed: () {},
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
                                      '${ticketmodel.ticketImage}'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                            width: 5,
                          ),
                          Text(
                            '${ticketmodel.category}',
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
