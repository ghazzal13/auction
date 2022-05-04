import 'package:flutter/material.dart';

import 'notification_screen.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  int currentIndex = 0;
  bool isLiked = false;
  int Likes = 10;
  int LikeCount = 1;
  int Add = 500;
  int AddCount = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Auction',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => ShoppingCartScreen(),
          //       ),
          //     );
          //   },
          //   icon: Icon(Icons.shopping_cart_rounded),
          // ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ),
              );
            },
            icon: (Icon(Icons.notifications)),
          ),
          IconButton(
            onPressed: () {},
            icon: (Icon(Icons.category)),
          ),
          IconButton(
            onPressed: () {},
            icon: (Icon(Icons.sort)),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.black,
        fixedColor: Colors.teal,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home Page'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.radar,
              ),
              label: 'Rader'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
              ),
              label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.face,
              ),
              label: 'Profile'),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'https://i.pinimg.com/564x/0f/c8/7f/0fc87ffeec70af2e12ed01d22f06c2b1.jpg'),
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment:MainAxisAlignment.start,
              //crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsScreen(),
                        ),
                      );
                    },
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
                              /*Container(
                                width: MediaQuery.of(context).size.width*0.3,
                                height:150,
                                margin: new EdgeInsets.fromLTRB(200,0,0,0),
                               // color: Colors.black87,
                                decoration: BoxDecoration(
                    image: DecorationImage(
                          image:  NetworkImage("https://i.pinimg.com/564x/70/f9/dd/70f9dd78e5d27729b98d74cdd4c78484.jpg"),),
                  ),
                              ),*/
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
                                      onPressed: () {
                                        setState(() {
                                          Likes++;
                                          //print(Likes);
                                        });
                                      },
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  /*Container(
                                    child: TextButton.icon(
                                        onPressed: () {},
                                        icon: (Icon(
                                          Icons.add_comment_rounded,
                                          size: 25,
                                          color: Colors.black,
                                        )),
                                        label: Text(
                                          'Comment',
                                          style: TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        )),
                                  ),*/
                                  Text('$Add'),
                                  Container(
                                    height: 30,
                                    width: 40,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        setState(() {
                                          Add++;
                                          //print(Likes);
                                        });
                                      },
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
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 35,
                          ),
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
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.teal,
                          backgroundImage: NetworkImage(
                              'https://as2.ftcdn.net/v2/jpg/00/65/77/27/1000_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg'),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.teal.withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              'Comment Comment Comment Comment Comment Comment Comment Comment Comment',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.teal[400],
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Write Comment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    //color: Colors.teal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Comment',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
