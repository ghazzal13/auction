
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_nav_bar.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:Container(
          alignment: Alignment.center,
          child: Text('Message',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,

            ),),
        ),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                 margin: EdgeInsets.only(bottom:460),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                        Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.teal,
                                            backgroundImage: NetworkImage(
                                                'https://as2.ftcdn.net/v2/jpg/00/65/77/27/1000_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg'),
                                          ),

                                        ),
                                      ],

                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Container(
                                        height: 60,
                                        width: MediaQuery.of(context).size.width*0.7,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          color: Colors.teal.withOpacity(0.3),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Container(
                                            child: Text('Message From Nada',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
