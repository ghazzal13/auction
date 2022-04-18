import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_nav_bar.dart';
import 'notification_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Search',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
            icon: (Icon(Icons.menu)),
          ),
        ],
      ),
      bottomNavigationBar: CustomButtom(),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'https://i.pinimg.com/564x/0f/c8/7f/0fc87ffeec70af2e12ed01d22f06c2b1.jpg'),
        )),
        child: Center(
          child: Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Icon(
                                (Icons.search),
                                color: Colors.teal,
                                size: 45,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.teal.withOpacity(0.1),
                                  ),
                                  height: 50,
                                  width: 293,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      //suffixIcon: Icon(Icons.search),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.teal,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.teal,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
