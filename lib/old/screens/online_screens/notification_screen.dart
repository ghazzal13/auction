import 'package:auction/cubit/cubit.dart';
import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/screens/online_screens/auction_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'online_auction_event_screen.dart';

class NotificationScreeen extends StatefulWidget {
  const NotificationScreeen({Key? key}) : super(key: key);

  @override
  State<NotificationScreeen> createState() => _NotificationScreeenState();
}

class _NotificationScreeenState extends State<NotificationScreeen> {
  CollectionReference db = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('notificatoin'),
    ));
  }
}
