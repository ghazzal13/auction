import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'online_comments_screen.dart';
import 'custom_nav_bar.dart';

class SortScreen extends StatefulWidget {
  const SortScreen({Key? key}) : super(key: key);

  @override
  _SortScreenState createState() => _SortScreenState();
}

class _SortScreenState extends State<SortScreen> {
  int Value = -1;
  setValue(int value) {
    setState(() {
      Value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Sort',
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
                  builder: (context) => SortScreen(),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Price:',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: Value,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'From Low To High',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(value: 2, groupValue: Value, onChanged: (value) {}),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'From High To Low',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: Value,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'More Than 1000 LE',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 4,
                      groupValue: Value,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Less Than 1000 LE',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Categories:',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                        value: 'car', groupValue: Value, onChanged: (value) {}),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Cars',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: Value,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Mobiles',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 4,
                      groupValue: Value,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Watches',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 4,
                      groupValue: Value,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Games',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 4,
                      groupValue: Value,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'electonices',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 4,
                      groupValue: Value,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'books',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.teal[400],
                  ),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
