import 'package:flutter/material.dart';

class NotificationScreeen extends StatefulWidget {
  const NotificationScreeen({Key? key}) : super(key: key);

  @override
  State<NotificationScreeen> createState() => _NotificationScreeenState();
}

class _NotificationScreeenState extends State<NotificationScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: const Text(
          'Auction',
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
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
        child: Column(
          children: [
            const Center(
              child: Text('notification'),
            ),
          ],
        ),
      ),
    );
  }
}
