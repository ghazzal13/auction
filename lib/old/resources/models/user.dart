import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? uid;
  String? name;
  String? address;
  String? image;

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.address,
    this.image,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      address: map['address'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'name': name,
        'address': address,
        'image': image,
      };
}
