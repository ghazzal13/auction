class TicketModel {
  String? uid;
  String? name;
  String? image;
  String? ticketImage;
  String? ticketId;
  String? titel;
  DateTime? datePublished;
  DateTime? dateTime;
  String? address;
  String? description;
  int? price;
  bool? isaccept;
  bool? isWaiting;
  List? owner = [];

  TicketModel({
    this.uid,
    this.name,
    this.image,
    this.ticketImage,
    this.ticketId,
    this.address,
    this.datePublished,
    this.dateTime,
    this.titel,
    this.description,
    this.price,
    this.isaccept,
    this.isWaiting,
    this.owner,
  });

  factory TicketModel.fromMap(map) {
    return TicketModel(
      uid: map['uid'],
      name: map['name'],
      image: map['image'],
      ticketImage: map['ticketImage'],
      ticketId: map['ticketId'],
      address: map['address'],
      datePublished: map['datePublished'],
      dateTime: map['dateTime'],
      titel: map['titel'],
      price: map['price'],
      description: map['description'],
      isaccept: map['isaccept'],
      isWaiting: map['isWaiting'],
      owner: map['owner'],
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'image': image,
        'ticketImage': ticketImage,
        'ticketId': ticketId,
        'address': address,
        'datePublished': datePublished,
        'owner': owner,
        'dateTime': dateTime,
        'titel': titel,
        'price': price,
        'description': description,
        'isaccept': isaccept,
        'isWaiting': isWaiting,
      };
}
