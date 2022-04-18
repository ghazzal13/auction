import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_nav_bar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: (Icon(
              Icons.category_rounded,
              color: Colors.black87,
            )),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text('Featured Categories:',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          height:140,
                          //margin: new EdgeInsets.fromLTRB(200,0,0,0),
                          // color: Colors.black87,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:  NetworkImage("https://i.pinimg.com/564x/70/f9/dd/70f9dd78e5d27729b98d74cdd4c78484.jpg"),),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          height:140,
                          //margin: new EdgeInsets.fromLTRB(200,0,0,0),
                          // color: Colors.black87,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:  NetworkImage("https://i.pinimg.com/564x/70/f9/dd/70f9dd78e5d27729b98d74cdd4c78484.jpg"),),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          height:140,
                          //margin: new EdgeInsets.fromLTRB(200,0,0,0),
                          // color: Colors.black87,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:  NetworkImage("https://i.pinimg.com/564x/70/f9/dd/70f9dd78e5d27729b98d74cdd4c78484.jpg"),),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text('Browse All',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          height:140,
                          //margin: new EdgeInsets.fromLTRB(200,0,0,0),
                          // color: Colors.black87,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:  NetworkImage("https://i.pinimg.com/564x/70/f9/dd/70f9dd78e5d27729b98d74cdd4c78484.jpg"),),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          height:140,
                          //margin: new EdgeInsets.fromLTRB(200,0,0,0),
                          // color: Colors.black87,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:  NetworkImage("https://i.pinimg.com/564x/70/f9/dd/70f9dd78e5d27729b98d74cdd4c78484.jpg"),),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          height:140,
                          //margin: new EdgeInsets.fromLTRB(200,0,0,0),
                          // color: Colors.black87,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:  NetworkImage("https://i.pinimg.com/564x/70/f9/dd/70f9dd78e5d27729b98d74cdd4c78484.jpg"),),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  height:140,
                  //margin: new EdgeInsets.fromLTRB(200,0,0,0),
                  // color: Colors.black87,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:  NetworkImage("https://i.pinimg.com/564x/70/f9/dd/70f9dd78e5d27729b98d74cdd4c78484.jpg"),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  height:140,
                  //margin: new EdgeInsets.fromLTRB(200,0,0,0),
                  // color: Colors.black87,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:  NetworkImage("https://i.pinimg.com/564x/70/f9/dd/70f9dd78e5d27729b98d74cdd4c78484.jpg"),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
