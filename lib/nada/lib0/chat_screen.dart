import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class chat extends StatefulWidget {
  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Container(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("https://i.pinimg.com/564x/0f/c8/7f/0fc87ffeec70af2e12ed01d22f06c2b1.jpg"),
                  radius: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Nada Adel')
              ],
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.call, color: Colors.white, size: 35)),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.close_outlined,
                color: Colors.white,
                size: 40,
              )),
        ],
      ),
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                  NetworkImage(
                      'https://i.pinimg.com/564x/0f/c8/7f/0fc87ffeec70af2e12ed01d22f06c2b1.jpg'),
                )),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => Text("Chat"),
                        itemCount: 100,
                      )),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(48),
                              color: Colors.teal.withOpacity(0.2),
                            ),
                            height: 55,
                            child: TextField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(48),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(48),
                                  ),
                                  hintText: "Write a reply...",
                                  hintStyle: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 18),
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: InkWell(
                            child: Icon(
                              Icons.send,
                              size: 40,
                              color: Colors.teal,
                            ),
                            onLongPress: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}