import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? uid;
  String? name;
  String? image;
  String? postImage;
  String? postId;
  String? price;
  String? titel;
  String? dateTime;
  String? category;
  String? description;
  List? comments;

  PostModel(
      {this.uid,
      this.name,
      this.image,
      this.postImage,
      this.postId,
      this.category,
      this.dateTime,
      this.titel,
      this.price,
      this.description,
      this.comments});

  factory PostModel.fromMap(map) {
    return PostModel(
      uid: map['uid'],
      name: map['name'],
      image: map['image'],
      price: map['price'],
      postImage: map['postImage'],
      postId: map['postId'],
      category: map['category'],
      dateTime: map['dateTime'],
      titel: map['titel'],
      description: map['description'],
      comments: map['comments'],
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
        'titel': titel,
        'description': description,
        'comments': comments,
      };
}
