import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? uid;
  String? name;
  String? image;
  String? postImage;
  String? postId;
  String? price;
  String? titel;
  DateTime? dateTime;
  DateTime? postTime;
  String? category;
  String? description;
  bool? isStarted = false;

  PostModel(
      {this.uid,
      this.name,
      this.image,
      this.postImage,
      this.postId,
      this.category,
      this.dateTime,
      this.postTime,
      this.titel,
      this.price,
      this.description,
      this.isStarted});

  factory PostModel.fromMap(map) {
    return PostModel(
      uid: map['uid'],
      name: map['name'],
      image: map['image'],
      price: map['price'],
      postImage: map['postImage'],
      postId: map['postId'],
      category: map['category'],
      dateTime: DateTime.parse(map['dateTime'].toDate().toString()),
      postTime: DateTime.parse(map['postTime'].toDate().toString()),
      titel: map['titel'],
      description: map['description'],
      isStarted: map['isStarted'],
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'image': image,
        'postImage': postImage,
        'postId': postId,
        'price': price,
        'category': category,
        'dateTime': dateTime,
        'postTime': postTime,
        'titel': titel,
        'description': description,
        'isStarted': isStarted,
      };
}
