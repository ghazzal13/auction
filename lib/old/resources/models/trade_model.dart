class TradeItemModel {
  String? uid;
  String? name;
  String? image;
  String? tradeItemImage;
  String? tradeItemId;
  String? titel;
  String? description;

  String? dateTime;

  TradeItemModel({
    this.uid,
    this.name,
    this.image,
    this.tradeItemImage,
    this.tradeItemId,
    this.dateTime,
    this.titel,
    this.description,
  });

  factory TradeItemModel.fromMap(map) {
    return TradeItemModel(
      uid: map['uid'],
      name: map['name'],
      image: map['image'],
      tradeItemImage: map['ticketImage'],
      tradeItemId: map['ticketId'],
      dateTime: map['dateTime'],
      titel: map['titel'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'image': image,
        'ticketImage': tradeItemImage,
        'ticketId': tradeItemId,
        'dateTime': dateTime,
        'titel': titel,
        'description': description,
      };
}
