import 'package:auction/cubit/cubit.dart';
import 'package:auction/cubit/states.dart';
import 'package:auction/old/screens/offline_screens/offline_manage_screen.dart';
import 'package:auction/old/screens/online_screens/online_manage_screen.dart';
import 'package:auction/old/screens/trade/trade_manage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuHomeBottomBar extends StatefulWidget {
  const MenuHomeBottomBar({Key? key}) : super(key: key);

  @override
  State<MenuHomeBottomBar> createState() => _MenuHomeBottomBarState();
}

class _MenuHomeBottomBarState extends State<MenuHomeBottomBar> {
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
                            AuctionCubit.get(context).onItemTapped(1);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OnlineMangScreen()),
                                (route) => false);
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => const OnlineMangScreen(),
                            //   ),
                            // );
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
                          onTap: () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OfflineMangScreen()),
                              (route) => false),
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
                          onTap: () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TradeMangScreen()),
                              (route) => false),
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
