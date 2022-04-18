import 'package:auction/old/screens/login_screen.dart';
import 'package:auction/old/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomePagesScreen extends StatefulWidget {
  const HomePagesScreen({Key? key}) : super(key: key);

  @override
  _HomePagesScreenState createState() => _HomePagesScreenState();
}

class _HomePagesScreenState extends State<HomePagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/222.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Container(
                  child: Image(
                image: AssetImage(
                  'assets/logo1.png',
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.teal[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                        color: Colors.teal[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
