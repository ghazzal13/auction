class TicketModel {
  String? uid;
  String? name;
  String? image;
  String? ticketImage;
  String? ticketId;
  String? titel;
  DateTime? datePublished;
  DateTime? dateTime;
  String? category;
  String? address;
  String? description;

  TicketModel({
    this.uid,
    this.name,
    this.image,
    this.ticketImage,
    this.ticketId,
    this.category,
    this.address,
    this.datePublished,
    this.dateTime,
    this.titel,
    this.description,
  });

  factory TicketModel.fromMap(map) {
    return TicketModel(
      uid: map['uid'],
      name: map['name'],
      image: map['image'],
      ticketImage: map['ticketImage'],
      ticketId: map['ticketId'],
      category: map['category'],
      address: map['address'],
      datePublished: map['datePublished'],
      dateTime: map['dateTime'],
      titel: map['titel'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'image': image,
        'ticketImage': ticketImage,
        'ticketId': ticketId,
        'category': category,
        'address': address,
        'datePublished': datePublished,
        'dateTime': dateTime,
        'titel': titel,
        'description': description,
      };
}
