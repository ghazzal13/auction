class OfferModel {
  String? uid;
  String? name;
  String? image;
  String? tradeItemImage;
  String? tradeItemId;

  String? description;
  String? titel;
  DateTime? datePublished;
  String? offerId;
  String? offertitel;
  String? offerprice;
  String? offerDescription;
  String? offerImage;
  String? offerUserID;
  String? offerUserImage;
  String? offerUsername;
  bool? isEnd;
  bool? isFinish;
  String? offeraccept;

  List? winners = [];

  OfferModel({
    this.uid,
    this.name,
    this.image,
    this.tradeItemId,
    this.tradeItemImage,
    this.titel,
    this.description,
    this.datePublished,
    this.offerId,
    this.offertitel,
    this.offerImage,
    this.offerprice,
    this.offerDescription,
    this.offerUserID,
    this.offerUserImage,
    this.offerUsername,
    this.isEnd,
    this.offeraccept,
    this.winners,
    this.isFinish,
  });

  factory OfferModel.fromMap(map) {
    return OfferModel(
      uid: map['uid'],
      name: map['name'],
      image: map['image'],
      titel: map['titel'],
      tradeItemImage: map['tradeItemImage'],
      tradeItemId: map['tradeItemId'],
      description: map['description'],
      datePublished: map['datePublished'],
      offerId: map['offerId'],
      offertitel: map['offertitel'],
      offerImage: map['offerImage'],
      offerprice: map['offerprice'],
      offerDescription: map['offerDescription'],
      offerUserID: map['offerUserID'],
      offerUserImage: map['offerUserImage'],
      offerUsername: map['offerUsername'],
      isEnd: map['isEnd'],
      offeraccept: map['offeraccept'],
      winners: map['winners'],
      isFinish: map['isFinish'],
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'image': image,
        'tradeItemImage': tradeItemImage,
        'tradeItemId': tradeItemId,
        'titel': titel,
        'description': description,
        'datePublished': datePublished,
        'offerId': offerId,
        'offertitel': offertitel,
        'offerImage': offerImage,
        'offerprice': offerprice,
        'offerDescription': offerDescription,
        'offerUsername': offerUsername,
        'offerUserImage': offerUserImage,
        'offerUserID': offerUserID,
        'isEnd': isEnd,
        'offeraccept': offeraccept,
        'winners': winners,
        'isFinish': isFinish,
      };
}
