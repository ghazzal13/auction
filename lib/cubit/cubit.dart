import 'dart:io';

import 'package:auction/cubit/states.dart';
import 'package:auction/old/resources/models/comment_model.dart';
import 'package:auction/old/resources/models/event_model.dart';
import 'package:auction/old/resources/models/offer_model.dart';
import 'package:auction/old/resources/models/post_model.dart';
import 'package:auction/old/resources/models/ticket.dart';
import 'package:auction/old/resources/models/trade_model.dart';
import 'package:auction/old/resources/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class AuctionCubit extends Cubit<AuctionStates> {
  AuctionCubit() : super(AuctionInitialState());

  static AuctionCubit get(context) => BlocProvider.of(context);

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AuctionProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AuctionProfileImagePickedErrorState());
    }
  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AuctionPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AuctionPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(AuctionRemovePostImageState());
  }

  UserModel model = UserModel();
  void getUserData() {
    emit(AuctionGetUserLoadingState());
    String? uid;
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      print(value.data());
      this.model = UserModel.fromMap(value.data());
      emit(AuctionGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AuctionGetUserErrorState(error.toString()));
    });
  }

  String? profileImageUrl;
  void upLoadProfileImage() {
    emit(AuctionUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        emit(AuctionUploadProfileImageSuccessState());
        print(value);
        profileImageUrl = value;
        updateUser(image: profileImageUrl);
      }).catchError((error) {
        emit(AuctionUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(AuctionUploadProfileImageErrorState());
    });
  }

  void updateUser({
    String? image,
  }) {
    UserModel usermodel = UserModel(
      name: model.name,
      email: model.email,
      image: image,
      uid: model.uid,
      address: model.address,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uid)
        .update(usermodel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(AuctionUserUpdateErrorState());
    });
  }

  void updatePostState({
    bool? isStarted,
    bool? isFinish,
    String? winner,
  }) {
    PostModel updatemodel = PostModel(
      name: postByID.name,
      image: model.image,
      uid: postByID.uid,
      startAuction: postByID.startAuction,
      endAuction: postByID.endAuction,
      postTime: postByID.postTime,
      description: postByID.description,
      postImage: postByID.postImage,
      postId: postByID.postId,
      category: postByID.category,
      titel: postByID.titel,
      price: postByID.price,
      isStarted: isStarted ?? postByID.isStarted,
      isFinish: isFinish ?? postByID.isFinish,
      winner: winner ?? postByID.winner,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postByID.postId)
        .update(updatemodel.toMap())
        .then((value) {
      getPosts();
    }).catchError((error) {
      emit(AuctionStartPostUpdateUpdateErrorState());
    });
  }

  void uploadPostImage({
    String? titel,
    DateTime? startAuction,
    DateTime? postTime,
    String? category,
    String? description,
    int? price,
  }) {
    emit(AuctionCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        emit(AuctionUploadProfileImageSuccessState());
        print(value);
        createPost(
          startAuction: startAuction,
          postTime: postTime,
          description: description,
          postImage: value,
          category: category,
          titel: titel,
          price: price,
        );
      }).catchError((error) {
        emit(AuctionCreatePostErrorState());
      });
    }).catchError((error) {
      emit(AuctionCreatePostErrorState());
    });
  }

  void createPost({
    String? name,
    String? image,
    String? postImage,
    String? titel,
    DateTime? startAuction,
    DateTime? postTime,
    String? category,
    String? description,
    int? price,
  }) {
    emit(AuctionCreatePostLoadingState());
    String postId = const Uuid().v1();
    PostModel pmodel = PostModel(
      name: model.name,
      image: model.image,
      uid: model.uid,
      startAuction: startAuction,
      endAuction: startAuction!.add(const Duration(hours: 3)),
      postTime: postTime,
      description: description,
      postImage: postImage,
      postId: postId,
      category: category,
      titel: titel,
      price: price,
      isStarted: false,
      isFinish: false,
      winner: null,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .set(pmodel.toMap())
        .then((value) {
      emit(AuctionCreatePostSuccessState());
    }).catchError((error) {
      emit(AuctionCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  Future<List<PostModel>> getPosts() async {
    posts.clear();
    emit(AuctionGetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          print(element.data()['postImage']);
          posts.add(PostModel.fromMap(
            element.data(),
          ));
        }).catchError((error) {});
      });

      emit(AuctionGetPostSuccessState());
    }).catchError((error) {
      emit(AuctionGetPostErrorState(error.toString()));
    });
    return posts;
  }

  PostModel postByID = PostModel();
  Future<dynamic> getPostById({required String id}) async {
    emit(AuctionGetPostLoadingState());
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .get()
        .then((value) {
      // print(value.data()!['postImage']);
      // print(value.data()!['image']);
      print(value.data()!['uid']);
      this.postByID = PostModel.fromMap(value.data());
      // return postByID;
      emit(AuctionGetPostSuccessState());
    }).catchError((error) {
      emit(AuctionGetPostErrorState(error.toString()));
    });
    return postByID;
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(AuctionLikePostSuccessState());
    }).catchError((error) {
      emit(AuctionLikePostErrorState(error.toString()));
    });
  }

  void writeComment(
    String collection,
    String postId, {
    String? name,
    String? image,
    String? dateTime,
    required String? comment,
  }) {
    emit(AuctionWriteCommentLoadingState());
    String commentId = const Uuid().v1();
    CommentModel cmodel = CommentModel(
        name: model.name,
        image: model.image,
        uid: model.uid,
        dateTime: dateTime,
        comment: comment,
        commentId: commentId,
        postId: postId);
    FirebaseFirestore.instance
        .collection(collection)
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .set(cmodel.toMap())
        .then((value) {
      emit(AuctionWriteCommentSuccessState());
    }).catchError((error) {
      emit(AuctionWriteCommentErrorState());
    });
  }

  List<CommentModel> comments1 = [];
  // List<String> commentId = [];
  // List<int> comments = [];
  void getComments(postId, String collection) {
    emit(AuctionGetCommentLoadingState());
    FirebaseFirestore.instance
        .collection(collection)
        .doc(postId)
        .collection('comments')
        .snapshots()
        .listen((event) {
      comments1 = [];
      event.docs.forEach((element) {
        comments1.add(CommentModel.fromMap(
          element.data(),
        ));
      });
      emit(AuctionGetCommentSuccessState());
    });
  }

  File? TicketImage;
  Future<void> getTicketImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      TicketImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AuctionTicketImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AuctionTicketImagePickedErrorState());
    }
  }

  void removeTicketImage() {
    TicketImage = null;
    emit(AuctionRemoveTicketImageState());
  }

  void uploadTicketImage({
    String? titel,
    DateTime? dateTime,
    String? category,
    String? description,
    String? price,
  }) {
    emit(AuctionCreateTicketLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('tickets/${Uri.file(TicketImage!.path).pathSegments.last}')
        .putFile(TicketImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        emit(AuctionUploadProfileImageSuccessState());
        print(value);
        createTicket(
          dateTime: dateTime,
          description: description,
          ticketImage: value,
          category: category,
          titel: titel,
          price: price,
        );
      }).catchError((error) {
        emit(AuctionCreateTicketErrorState());
      });
    }).catchError((error) {
      emit(AuctionCreateTicketErrorState());
    });
  }

  void createTicket({
    String? name,
    String? image,
    String? ticketImage,
    String? titel,
    DateTime? dateTime,
    String? category,
    String? description,
    String? price,
  }) {
    emit(AuctionCreateTicketLoadingState());
    String ticketId = const Uuid().v1();
    TicketModel tmodel = TicketModel(
      name: model.name,
      image: model.image,
      uid: model.uid,
      datePublished: DateTime.now(),
      dateTime: dateTime,
      description: description,
      ticketImage: ticketImage,
      ticketId: ticketId,
      category: category,
      titel: titel,
    );

    FirebaseFirestore.instance
        .collection('tickets')
        .doc(ticketId)
        .set(tmodel.toMap())
        .then((value) {
      emit(AuctionCreateTicketSuccessState());
    }).catchError((error) {
      emit(AuctionCreateTicketErrorState());
    });
  }

  List<TicketModel> ticket = [];
  List<String> ticketId = [];
  List<int> ticketLikes = [];
  void getTickets() {
    ticket.clear();
    emit(AuctionGetTicketLoadingState());
    FirebaseFirestore.instance.collection('tickets').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          ticketLikes.add(value.docs.length);
          ticketId.add(element.id);
          ticket.add(TicketModel.fromMap(
            element.data(),
          ));
        }).catchError((error) {});
      });

      emit(AuctionGetTicketSuccessState());
    }).catchError((error) {
      emit(AuctionGetTicketErrorState(error.toString()));
    });
  }

  File? TradeItemImage;
  Future<void> getTradeItemImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      TradeItemImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AuctionTradeItemImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AuctionTradeItemImagePickedErrorState());
    }
  }

  void removeTradeItemImage() {
    TradeItemImage = null;
    emit(AuctionRemoveTradeItemImageState());
  }

  void createTradeItem({
    String? name,
    String? image,
    String? tradeItemImage,
    String? titel,
    String? description,
    String? price,
  }) {
    emit(AuctionCreateTradeItemLoadingState());
    String tradeItemId = const Uuid().v1();
    TradeItemModel imodel = TradeItemModel(
      name: model.name,
      image: model.image,
      uid: model.uid,
      datePublished: DateTime.now(),
      description: description,
      tradeItemImage: tradeItemImage,
      tradeItemId: tradeItemId,
      titel: titel,
      isEnd: false,
    );
    FirebaseFirestore.instance
        .collection('tradeitem')
        .doc(tradeItemId)
        .set(imodel.toMap())
        .then((value) {
      emit(AuctionCreateTradeItemSuccessState());
    }).catchError((error) {
      emit(AuctionCreateTradeItemErrorState());
    });
  }

  void uploadTradeItemImage({
    String? titel,
    String? category,
    String? description,
    String? price,
  }) {
    emit(AuctionCreateTradeItemLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('tradeItems/${Uri.file(TradeItemImage!.path).pathSegments.last}')
        .putFile(TradeItemImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        emit(AuctionUploadProfileImageSuccessState());
        print(value);
        createTradeItem(
          description: description,
          tradeItemImage: value,
          titel: titel,
          price: price,
        );
      }).catchError((error) {
        emit(AuctionCreateTradeItemErrorState());
      });
    }).catchError((error) {
      emit(AuctionCreateTradeItemErrorState());
    });
  }

  List<TradeItemModel> TradeItems = [];
  List<String> TradeItemId = [];
  List<int> TradeItemsLikes = [];
  void getTradeItems() {
    TradeItems.clear();
    emit(AuctionGetTradeItemLoadingState());
    FirebaseFirestore.instance.collection('tradeitem').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          TradeItemsLikes.add(value.docs.length);
          TradeItemId.add(element.id);

          TradeItems.add(TradeItemModel.fromMap(
            element.data(),
          ));
        }).catchError((error) {});
      });

      emit(AuctionGetTradeItemSuccessState());
    }).catchError((error) {
      emit(AuctionGetTradeItemErrorState(error.toString()));
    });
  }

  List<dynamic> search = [];
  late String searchKey;
  void getSearch(
    String s,
  ) {
    search.clear();
    searchKey = s;
    FirebaseFirestore.instance
        .collection('posts')
        .where('titel', isGreaterThanOrEqualTo: searchKey)
        .where('titel', isLessThan: searchKey + 'z')
        .snapshots()
        .listen((event) {
      // search.clear();
      event.docs.forEach((element) {
        search.add(PostModel.fromMap(
          element.data(),
        ));

        print(element.data()['titel']);
      });
      emit(AuctionGetCommentSuccessState());
    });
  }

  void encreasePrice(
    String collection,
    String postId, {
    String? name,
    String? image,
    String? dateTime,
    required int? price,
  }) {
    emit(AuctionWritePricesLoadingState());
    String encreasePriceId = const Uuid().v1();
    EventModel emodel = EventModel(
        name: model.name,
        image: model.image,
        uid: model.uid,
        dateTime: dateTime,
        price: price,
        encreasePriceId: encreasePriceId,
        postId: postId);
    FirebaseFirestore.instance
        .collection(collection)
        .doc(postId)
        .collection('prices')
        .doc(encreasePriceId)
        .set(emodel.toMap())
        .then((value) {
      emit(AuctionWritePricesSuccessState());
    }).catchError((error) {
      emit(AuctionWritePricesErrorState());
    });
  }

  List<EventModel> encreasePrices = [];
  // List<String> commentId = [];
  // List<int> comments = [];
  void getprice(postId, String collection, {String? id}) {
    emit(AuctionGetPricesLoadingState());

    FirebaseFirestore.instance
        .collection(collection)
        .doc(postId)
        .collection('prices')
        .orderBy('price', descending: true)
        .snapshots()
        .listen((event) {
      encreasePrices = [];
      event.docs.forEach((element) {
        encreasePrices.add(EventModel.fromMap(
          element.data(),
        ));
      });
      emit(AuctionGetPricesSuccessState());
    });
  }

  void updatePostPrice(
    int? price,
  ) {
    PostModel updatemodel = PostModel(
      name: postByID.name,
      image: model.image,
      uid: postByID.uid,
      startAuction: postByID.startAuction,
      postTime: postByID.postTime,
      description: postByID.description,
      postImage: postByID.postImage,
      postId: postByID.postId,
      category: postByID.category,
      titel: postByID.titel,
      price: price,
      isStarted: postByID.isStarted,
      isFinish: postByID.isFinish,
      winner: postByID.winner,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postByID.postId)
        .update(updatemodel.toMap())
        .then((value) {})
        .catchError((error) {
      emit(AuctionStartPostUpdateUpdateErrorState());
    });
  }

  File? OfferImage;
  Future<void> getofferImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      OfferImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AuctionMakeAnOfferImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AuctionMakeAnOfferImagePickedErrorState());
    }
  }

  void removeOfferImage() {
    OfferImage = null;
    emit(AuctionRemoveTradeItemImageState());
  }

  void makeAnOffer({
    required String? uid,
    required String? name,
    required String? image,
    required String? tradeItemImage,
    required String? titel,
    required String? description,
    required DateTime? datePublished,
    required String? tradeItemId,
    required String? offerImage,
    required String? offertitel,
    required String? offerDescription,
    required String? offerprice,
  }) {
    emit(AuctionMakeAnOfferLoadingState());
    String offerID = const Uuid().v1();
    OfferModel omodel = OfferModel(
      uid: uid,
      name: name,
      image: image,
      offerUsername: model.name,
      offerUserImage: model.image,
      offerUserID: model.uid,
      description: description,
      tradeItemImage: tradeItemImage,
      titel: titel,
      datePublished: datePublished,
      offerDescription: offerDescription,
      offerId: offerID,
      offerImage: offerImage,
      offerprice: offerprice,
      offertitel: offerImage,
      tradeItemId: tradeItemId,
      offeraccept: 'no one',
      isEnd: false,
    );
    FirebaseFirestore.instance
        .collection('offers')
        .doc(offerID)
        .set(omodel.toMap())
        .then((value) {
      emit(AuctionMakeAnOfferSuccessState());
    }).catchError((error) {
      emit(AuctionMakeAnOfferErrorState());
    });
  }

  Future uploadOfferImage({
    String? name,
    String? uid,
    String? image,
    String? tradeItemImage,
    String? titel,
    String? tradeItemId,
    String? description,
    DateTime? datePublished,
    String? offerImage,
    String? offertitel,
    String? offerDescription,
    String? offerprice,
    String? offerUsername,
    String? offerUserImage,
    String? offerUserID,
  }) async {
    emit(AuctionMakeAnOfferLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('tradeItems/${Uri.file(OfferImage!.path).pathSegments.last}')
        .putFile(OfferImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        emit(AuctionUploadofferImageSuccessState());
        print(value);
        makeAnOffer(
            description: description,
            tradeItemImage: tradeItemImage,
            titel: titel,
            image: image,
            name: name,
            uid: uid,
            offerDescription: offerDescription,
            offerImage: value,
            offerprice: offerprice,
            offertitel: offertitel,
            tradeItemId: tradeItemId,
            datePublished: datePublished);
      }).catchError((error) {
        emit(AuctionMakeAnOfferErrorState());
      });
    }).catchError((error) {
      emit(AuctionMakeAnOfferErrorState());
    });
  }

  void acceptOffer({
    required String? uid,
    required String? name,
    required String? offerID,
    required String? image,
    required String? tradeItemImage,
    required String? titel,
    required String? description,
    required String? tradeItemId,
    required String? offerImage,
    required String? offertitel,
    required String? offerDescription,
    required String? offerprice,
    required DateTime? datePublished,
  }) {
    OfferModel offermodel = OfferModel(
      uid: uid,
      name: name,
      image: image,
      offerUsername: model.name,
      offerUserImage: model.image,
      offerUserID: model.uid,
      description: description,
      tradeItemImage: tradeItemImage,
      titel: titel,
      offerDescription: offerDescription,
      offerId: offerID,
      offerImage: offerImage,
      offerprice: offerprice,
      offertitel: offerImage,
      tradeItemId: tradeItemId,
      offeraccept: model.uid,
      isEnd: true,
    );
    endTrade(
        uid: uid,
        name: name,
        image: image,
        tradeItemImage: tradeItemImage,
        titel: titel,
        description: description,
        tradeItemId: tradeItemId,
        datePublished: datePublished);
    FirebaseFirestore.instance
        .collection('offers')
        .doc(offerID)
        .update(offermodel.toMap())
        .then((value) {})
        .catchError((error) {
      emit(AuctionStartPostUpdateUpdateErrorState());
    });
  }

  void endTrade({
    required String? uid,
    required String? name,
    required String? image,
    required String? tradeItemImage,
    required String? titel,
    required String? description,
    required String? tradeItemId,
    required DateTime? datePublished,
  }) {
    TradeItemModel ixmodel = TradeItemModel(
      name: name,
      image: image,
      uid: uid,
      datePublished: datePublished,
      description: description,
      tradeItemImage: tradeItemImage,
      tradeItemId: tradeItemId,
      titel: titel,
      isEnd: true,
    );
    FirebaseFirestore.instance
        .collection('tradeitem')
        .doc(tradeItemId)
        .update(ixmodel.toMap())
        .then((value) {})
        .catchError((error) {
      emit(AuctionStartPostUpdateUpdateErrorState());
    });
  }

  void cancelOffer({
    required String? uid,
    required String? name,
    required String? offerID,
    required String? image,
    required String? tradeItemImage,
    required String? titel,
    required String? description,
    required String? tradeItemId,
    required String? offerImage,
    required String? offertitel,
    required String? offerDescription,
    required String? offerprice,
  }) {
    OfferModel offermodel = OfferModel(
      uid: uid,
      name: name,
      image: image,
      offerUsername: model.name,
      offerUserImage: model.image,
      offerUserID: model.uid,
      description: description,
      tradeItemImage: tradeItemImage,
      titel: titel,
      offerDescription: offerDescription,
      offerId: offerID,
      offerImage: offerImage,
      offerprice: offerprice,
      offertitel: offerImage,
      tradeItemId: tradeItemId,
      offeraccept: 'no one',
      isEnd: true,
    );
    FirebaseFirestore.instance
        .collection('offers')
        .doc(offerID)
        .update(offermodel.toMap())
        .then((value) {})
        .catchError((error) {
      emit(AuctionStartPostUpdateUpdateErrorState());
    });
  }

  //
}
