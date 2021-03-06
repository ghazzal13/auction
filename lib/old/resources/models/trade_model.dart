class TradeItemModel {
  String? uid;
  String? name;
  String? image;
  String? tradeItemImage;
  String? tradeItemId;
  String? titel;
  String? description;
  bool? isEnd;
  DateTime? datePublished;

  TradeItemModel({
    this.uid,
    this.name,
    this.image,
    this.tradeItemImage,
    this.tradeItemId,
    this.datePublished,
    this.titel,
    this.isEnd,
    this.description,
  });

  factory TradeItemModel.fromMap(map) {
    return TradeItemModel(
      uid: map['uid'],
      name: map['name'],
      image: map['image'],
      tradeItemImage: map['tradeItemImage'],
      tradeItemId: map['tradeItemId'],
      datePublished: map['datePublished'],
      titel: map['titel'],
      isEnd: map['isEnd'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'image': image,
        'tradeItemImage': tradeItemImage,
        'tradeItemId': tradeItemId,
        'datePublished': datePublished,
        'titel': titel,
        'isEnd': isEnd,
        'description': description,
      };
}
