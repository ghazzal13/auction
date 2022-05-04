import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/screens/offline_screens/offline_home_screen.dart';
import 'package:auction/old/screens/offline_screens/offline_manage_screen.dart';
import 'package:auction/old/screens/online_screens/online_manage_screen.dart';
import 'package:auction/old/screens/trade/trade_manage_screen.dart';
import 'package:auction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({Key? key}) : super(key: key);

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  @override
  // void initState() {
  //   super.initState();
  //   getdata();
  // }

  // void getdata() {
  //   // AuctionCubit.get(context).getUserData();
  // }

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
                            AuctionCubit.get(context).getUserData;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const OnlineMangScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(colors: [
                                    Colors.teal.shade300,
                                    Colors.greenAccent.shade200
                                  ])),
                              child: const Text('Online Auction',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OfflineMangScreen(),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Offline Auction',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(colors: [
                                    Colors.teal.shade300,
                                    Colors.greenAccent.shade200
                                  ])),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const TradeMangScreen(),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text('Trade',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              width: double.infinity,
                              //  width: 250,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(colors: [
                                    Colors.teal.shade300,
                                    Colors.greenAccent.shade200
                                  ])),
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
