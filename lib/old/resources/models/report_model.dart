class ReportModel {
  String? reportId;

  String? postUseruid;
  String? postUsername;
  String? postUserimage;
  String? postId;
  String? postImage;
  int? price;
  String? titel;
  DateTime? startAuction;
  DateTime? datePublished;

  String? category;
  String? description;
  String? reportType;
  String? reportText;
  String? address;
  String? uid;
  String? name;
  String? image;
  bool? cancelReport;
  DateTime? reportTime;

  ReportModel({
    this.uid,
    this.name,
    this.reportId,
    this.image,
    this.postUseruid,
    this.postUsername,
    this.postUserimage,
    this.postImage,
    this.postId,
    this.category,
    this.startAuction,
    this.datePublished,
    this.reportTime,
    this.titel,
    this.price,
    this.cancelReport,
    this.description,
    this.reportText,
    this.reportType,
    this.address,
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
      postImage: map['postImage'],
      postId: map['postId'],
      reportTime: map['reportTime'],
      price: map['price'],
      category: map['category'],
      startAuction: DateTime.parse(map['startAuction'].toDate().toString()),
      datePublished: DateTime.parse(map['datePublished'].toDate().toString()),
      titel: map['titel'],
      description: map['description'],
      reportText: map['reportText'],
      reportType: map['reportType'],
      address: map['address'],
      cancelReport: map['cancelReport'],
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'image': image,
        'reportId': reportId,
        'postUseruid': postUseruid,
        'postImage': postImage,
        'postUsername': postUsername,
        'postUserimage': postUserimage,
        'postId': postId,
        'price': price,
        'category': category,
        'cancelReport': cancelReport,
        'startAuction': startAuction,
        'datePublished': datePublished,
        'reportTime': reportTime,
        'titel': titel,
        'description': description,
        'reportText': reportText,
        'reportType': reportType,
        'address': address,
      };
}
