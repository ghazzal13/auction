import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? uid;
  String? name;
  String? image;
  String? postImage;
  String? postId;
  int? price;
  String? titel;
  DateTime? startAuction;
  DateTime? endAuction;
  DateTime? postTime;
  String? category;
  String? description;
  String? winner = 'no one';
  bool? isStarted = false;
  bool? isFinish = false;

  PostModel(
      {this.uid,
      this.name,
      this.image,
      this.postImage,
      this.postId,
      this.category,
      this.startAuction,
      this.endAuction,
      this.postTime,
      this.titel,
      this.price,
      this.description,
      this.winner,
      this.isFinish,
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
      startAuction: DateTime.parse(map['startAuction'].toDate().toString()),
      endAuction: DateTime.parse(map['endAuction'].toDate().toString()),
      postTime: DateTime.parse(map['postTime'].toDate().toString()),
      titel: map['titel'],
      description: map['description'],
      isStarted: map['isStarted'],
      isFinish: map['isFinish'],
      winner: map['winner'],
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
        'startAuction': startAuction,
        'endAuction': endAuction,
        'postTime': postTime,
        'titel': titel,
        'description': description,
        'isStarted': isStarted,
        'winner': winner,
        'isFinish': isFinish,
      };
}
