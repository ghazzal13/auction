
import 'package:flutter/material.dart';

import 'online_comments_screen.dart';

class BiddingScreen extends StatefulWidget {
  const BiddingScreen({Key? key}) : super(key: key);

  @override
  _BiddingScreenState createState() => _BiddingScreenState();
}

class _BiddingScreenState extends State<BiddingScreen> {
  bool isLiked = false;
  int Likes = 10;
  int LikeCount = 1;
  int Add = 500;
  int AddCount = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://i.pinimg.com/564x/0f/c8/7f/0fc87ffeec70af2e12ed01d22f06c2b1.jpg'),
            )),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 460),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.teal.withOpacity(0.2),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.teal,
                                              backgroundImage: NetworkImage(
                                                  'https://as2.ftcdn.net/v2/jpg/00/65/77/27/1000_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'UserName',
                                        style: TextStyle(
                                          color: Colors.teal[600],
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    alignment: Alignment.topLeft,
                                    //margin: EdgeInsets.fromLTRB(12,5,320,400),
                                    child: Text(
                                      'Title',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.teal[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    //margin: EdgeInsets.fromLTRB(12,0,320,400),
                                    child: Text(
                                      'Data Data Data',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.teal[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    //margin: EdgeInsets.fromLTRB(12,0,320,400),
                                    child: Text(
                                      'Duration',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.teal[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    //margin: EdgeInsets.fromLTRB(12,0,320,400),
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
                                      Text('$Likes'),
                                      Container(
                                        height: 30,
                                        width: 40,
                                        child: FloatingActionButton(
                                          onPressed: () {},
                                          heroTag: 'Likes+',
                                          backgroundColor: Colors.teal,
                                          mini: true,
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 40,
                                        child: FloatingActionButton(
                                          onPressed: () {},
                                          backgroundColor: Colors.teal,
                                          mini: true,
                                          child: Icon(
                                            Icons.comment,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 30,
                                          width: 40,
                                          child: FloatingActionButton(
                                            onPressed: () {},
                                            heroTag: 'Add',
                                            backgroundColor: Colors.teal,
                                            mini: true,
                                            child: Icon(
                                              Icons.plus_one,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                             Spacer(),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          child: Text(
                                            'First Price',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.teal,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width *
                                              0.3,
                                          height: 140,
                                          //margin: new EdgeInsets.fromLTRB(200,0,0,0),
                                          // color: Colors.black87,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://i.pinimg.com/564x/70/f9/dd/70f9dd78e5d27729b98d74cdd4c78484.jpg"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Text(
                                            'Category',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.teal,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width *
                                              0.2,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            // color: Colors.teal[400],
                                          ),
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'Rate',
                                              style: TextStyle(
                                                color: Colors.teal,
                                                fontSize: 20,
                                              ),
                                            ),
                                            //color: Colors.teal,
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
                      ),
                    ),
                  ],

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
