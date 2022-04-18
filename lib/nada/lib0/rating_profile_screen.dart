import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_nav_bar.dart';

class RatingProfileScreen extends StatefulWidget {
  const RatingProfileScreen({Key? key}) : super(key: key);

  @override
  _RatingProfileScreenState createState() => _RatingProfileScreenState();
}

class _RatingProfileScreenState extends State<RatingProfileScreen> {
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'Rating',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rating: $rating',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.teal),
                ),
                SizedBox(
                  height: 20,
                ),
                // RatingBar.builder(
                //   minRating:1,
                //   itemSize: 46,
                //   itemPadding: EdgeInsets.symmetric(horizontal: 4),
                //   itemBuilder:(context, _)=> Icon(Icons.star, color: Colors.amber,),
                //   onRatingUpdate: (rating) => setState(
                //           (){
                //         this.rating = rating;
                //       }
                //   ),
                //   updateOnDrag: true,
                //   initialRating:rating,
                // ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(colors: [
                      Colors.teal.shade200,
                      Colors.greenAccent.shade100
                    ]),
                  ),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Send Rating',
                        style: TextStyle(
                          color: Colors.teal[600],
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                        ),
                      )),
                )
              ],
            ),
          )),
        ));
  }
}
