import 'package:auction/nada/lib0/edit_post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsProfileScreen extends StatefulWidget {
  const PostsProfileScreen({Key? key}) : super(key: key);

  @override
  _PostsProfileScreenState createState() => _PostsProfileScreenState();
}

class _PostsProfileScreenState extends State<PostsProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Posts',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/222.jpg'),
        )),
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
                                Container(
                                  margin: EdgeInsets.only(right: 115),
                                  child: PopupMenuButton(
                                      color: Colors.black45.withOpacity(0.6),
                                      tooltip: 'Menu',
                                      child: Icon(
                                        Icons.more_vert,
                                        size: 28.0,
                                        color: Colors.teal,
                                      ),
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                                child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPostScreen(),
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  (Icon(
                                                    Icons.edit,
                                                    color: Colors.teal,
                                                    size: 30,
                                                  )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Edit Post',
                                                      style: TextStyle(
                                                        color: Colors.teal,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                            PopupMenuItem(
                                                child: GestureDetector(
                                              onTap: () {
                                                showDialog();
                                              },
                                              child: Row(
                                                children: [
                                                  (Icon(
                                                    Icons.delete,
                                                    color: Colors.teal,
                                                    size: 30,
                                                  )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Delete Post',
                                                      style: TextStyle(
                                                        color: Colors.teal,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ]),
                                ),
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
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
    );
  }

  void showDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Delete Post"),
          content: Text("Are you sure you want to Delete This Post?"),
          actions: [
            CupertinoDialogAction(
                child: Text("YES"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostsProfileScreen(),
                    ),
                  );
                }),
            CupertinoDialogAction(
              child: Text("NO"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostsProfileScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
