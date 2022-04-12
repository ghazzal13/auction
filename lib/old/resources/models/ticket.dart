class TicketModel {
  String? uid;
  String? name;
  String? image;
  String? ticketImage;
  String? ticketId;
  String? titel;
  String? dateTime;
  String? category;
  String? address;
  String? description;
  List? comments;

  TicketModel(
      {this.uid,
      this.name,
      this.image,
      this.ticketImage,
      this.ticketId,
      this.category,
      this.address,
      this.dateTime,
      this.titel,
      this.description,
      this.comments});

  factory TicketModel.fromMap(map) {
    return TicketModel(
      uid: map['uid'],
      name: map['name'],
      image: map['image'],
      ticketImage: map['ticketImage'],
      ticketId: map['ticketId'],
      category: map['category'],
      address: map['address'],
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
        'ticketImage': ticketImage,
        'ticketId': ticketId,
        'category': category,
        'address': address,
        'dateTime': dateTime,
        'titel': titel,
        'description': description,
        'comments': comments,
      };
}
