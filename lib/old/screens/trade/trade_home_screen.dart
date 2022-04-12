import 'package:flutter/material.dart';

class TradeHomeScreen extends StatefulWidget {
  const TradeHomeScreen({Key? key}) : super(key: key);

  @override
  State<TradeHomeScreen> createState() => _TradeHomeScreenState();
}

class _TradeHomeScreenState extends State<TradeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('trade home Scrren'),
      ),
    );
  }
}
