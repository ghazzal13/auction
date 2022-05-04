class ReportModel {
  String? reportId;
  String? uid;
  String? name;
  String? image;
  String? postUseruid;
  String? postUsername;
  String? postUserimage;

  int? price;
  String? titel;
  DateTime? startAuction;
  DateTime? postTime;
  String? category;
  String? description;
  String? reportText;

  ReportModel({
    this.uid,
    this.name,
    this.reportId,
    this.image,
    this.postUseruid,
    this.postUsername,
    this.postUserimage,
    this.category,
    this.startAuction,
    this.postTime,
    this.titel,
    this.price,
    this.description,
    this.reportText,
  });

  factory ReportModel.fromMap(map) {
    return ReportModel(
      uid: map['uid'],
      name: map['name'],
      reportId: map['reportId'],
      image: map['image'],
      postUseruid: map['postUseruid'],
      postUsername: map['postUsername'],
      postUserimage: map['postUserimage'],
      price: map['price'],
      category: map['category'],
      startAuction: DateTime.parse(map['startAuction'].toDate().toString()),
      postTime: DateTime.parse(map['postTime'].toDate().toString()),
      titel: map['titel'],
      description: map['description'],
      reportText: map['reportText'],
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'image': image,
        'reportId': reportId,
        'postUseruid': postUseruid,
        'postUsername': postUsername,
        'postUserimage': postUserimage,
        'price': price,
        'category': category,
        'startAuction': startAuction,
        'postTime': postTime,
        'titel': titel,
        'description': description,
        'reportText': reportText,
      };
}
