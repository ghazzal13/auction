import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/trade_model.dart';
import 'package:auction/old/resources/reuse_component.dart';
import 'package:auction/old/screens/shopping_cart_screen.dart';
import 'package:auction/old/screens/trade/item_details_screen.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradeHomeScreen extends StatefulWidget {
  const TradeHomeScreen({Key? key}) : super(key: key);

  @override
  State<TradeHomeScreen> createState() => _TradeHomeScreenState();
}

class _TradeHomeScreenState extends State<TradeHomeScreen> {
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
              'Trade Items',
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
                      AuctionCubit.get(context).TradeItems[index],
                      context,
                      index),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: AuctionCubit.get(context).TradeItems.length,
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

Widget buildTicketItem(TradeItemModel trademodel, context, index) =>
    GestureDetector(
        onTap: () {
          AuctionCubit.get(context)
              .getComments(trademodel.tradeItemId, 'tradeitem');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailsScreen(
                  AuctionCubit.get(context).TradeItemId[index], index),
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
                                      NetworkImage('${trademodel.image}'),
                                ),
                              ],
                            ),
                            Text(
                              '${trademodel.name}',
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
                            '${trademodel.titel}',
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
                            '${trademodel.dateTime}',
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
                                      '${trademodel.tradeItemImage}'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                            width: 5,
                          ),
                          const Text(
                            'ndddddddddddd',
                            style: TextStyle(
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
