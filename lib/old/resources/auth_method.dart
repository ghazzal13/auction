import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:auction/old/resources/models/user.dart' as model;

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Signing Up User

  // Future<model.User> getUserDetails() async {
  //   User currentUser = _auth.currentUser!;

  //   DocumentSnapshot documentSnapshot =
  //       await _firestore.collection('users').doc(currentUser.uid).get();

  //   return model.User.fromMap(documentSnapshot);
  // }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String address,
    // required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || address.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        model.UserModel _user = model.UserModel(
          image: 'https://i.stack.imgur.com/l60Hf.png',
          uid: cred.user!.uid,
          name: name,
          email: email,
          address: address,
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .set(_user.toMap());
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
