import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/screens/offline_screens/offline_home_screen.dart';
import 'package:auction/old/screens/offline_screens/offline_manage_screen.dart';
import 'package:auction/old/screens/online_screens/online_manage_screen.dart';
import 'package:auction/old/screens/trade/trade_manage_screen.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<AuctionCubit, AuctionStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var userModel = AuctionCubit.get(context).model;
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/222.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            // AuctionCubit.get(context).getPosts();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const OnlineMangScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 80,
                            child: const Text('Online Auction',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              color: primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OfflineMangScreen(),
                            ),
                          ),
                          child: Container(
                            height: 80,
                            child: const Text(
                              'Offline Auction',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              color: primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const TradeMangScreen(),
                            ),
                          ),
                          child: Container(
                            height: 80,
                            child: const Text('Trade',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
}
