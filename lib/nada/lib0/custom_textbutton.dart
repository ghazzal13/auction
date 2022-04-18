
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton({Key? key}) : super(key: key);

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(colors: [Colors.teal.shade200,Colors.greenAccent.shade100]),
      ),
      child: TextButton(onPressed: (){},
          child: Text('Send Rating',
            style: TextStyle(
              color: Colors.teal[600],
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),)),
    );
  }
}
