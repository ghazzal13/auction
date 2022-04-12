import 'package:flutter/material.dart';

const mobileBackgroundColor = Color.fromRGBO(0, 0, 0, 1);
const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
const auction = Color.fromARGB(250, 17, 175, 141);
const blueColor = Color.fromRGBO(0, 149, 246, 1);
const primaryColor = Colors.teal;
const secondaryColor = Color.fromARGB(255, 255, 255, 255);

/*
V/ActivityThread(31445): scheduleReceiver info = 
ActivityInfo{8adcd6 io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingReceiver} 
intent = Intent { act=com.google.android.c2dm.intent.RECEIVE flg=0x11080010 pkg=com.example.auction
 cmp=com.example.auction/io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingReceiver (has extras) } sync = true hasCode = 61723826
D/FLTF

ireMsgReceiver(31445): broadcast received for message

V/ActivityThread(31445): scheduleReceiver info = ActivityInfo{14b1529 com.google.firebase.iid.FirebaseInstanceIdReceiver}
 intent = Intent { act=com.google.android.c2dm.intent.RECEIVE flg=0x11080010 pkg=com.example.auction 
 cmp=com.example.auction/com.google.firebase.iid.FirebaseInstanceIdReceiver (has extras) } sync = true hasCode = 242394776


D/ColorExSystemServiceHelper(31445): checkColorExSystemService className = com.google.android.gms.gcm.PushMessagingRegistrarProxy
W/example.auctio(31445): Accessing hidden method Landroid/os/WorkSource;->add(I)Z (greylist, reflection, allowed)
W/example.auctio(31445): Accessing hidden method Landroid/os/WorkSource;->add(ILjava/lang/String;)Z (greylist, reflection, allowed)
W/example.auctio(31445): Accessing hidden method Landroid/os/WorkSource;->size()I (greylist, reflection, allowed)
W/example.auctio(31445): Accessing hidden method Landroid/os/WorkSource;->get(I)I (greylist, reflection, allowed)
W/example.auctio(31445): Accessing hidden method Landroid/os/WorkSource;->getName(I)Ljava/lang/String; (greylist, reflection, allowed)
I/flutter (31445): on background message
W/FirebaseMessaging(31445): Unable to log event: analytics library is missing
I/flutter (31445): {}
W/FirebaseMessaging(31445): Missing Default Notification Channel metadata in AndroidManifest. Default value will be used.

V/ActivityThread(31445): scheduleReceiver 
info = ActivityInfo{7b93612 io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingReceiver}
 intent = Intent { act=com.google.android.c2dm.intent.RECEIVE flg=0x11080010 
 pkg=com.example.auction cmp=com.example.auction/io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingReceiver 
 (has extras) } sync = true hasCode = 206594882
 
D/FLTFireMsgReceiver(31445): broadcast received for message
V/ActivityThread(31445): scheduleReceiver info = ActivityInfo{353893f com.google.firebase.iid.FirebaseInstanceIdReceiver} intent = Intent { act=com.google.android.c2dm.intent.RECEIVE flg=0x11080010 pkg=com.example.auction cmp=com.example.auction/com.google.firebase.iid.FirebaseInstanceIdReceiver (has extras) } sync = true hasCode = 142963086*/