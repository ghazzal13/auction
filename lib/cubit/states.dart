abstract class AuctionStates {}

class AuctionInitialState extends AuctionStates {}

class AuctionGetUserLoadingState extends AuctionStates {}

class AuctionGetUserSuccessState extends AuctionStates {}

class AuctionGetUserErrorState extends AuctionStates {
  final String error;

  AuctionGetUserErrorState(this.error);
}

class AuctionChangeBottomNavState extends AuctionStates {}

class AuctionNewPostState extends AuctionStates {}

class AuctionUserUpdateLoadingState extends AuctionStates {}

class AuctionProfileImagePickedSuccessState extends AuctionStates {}

class AuctionProfileImagePickedErrorState extends AuctionStates {}

class AuctionUploadProfileImageSuccessState extends AuctionStates {}

class AuctionUploadProfileImageErrorState extends AuctionStates {}

class AuctionUserUpdateErrorState extends AuctionStates {}

//post

class AuctionPostImagePickedSuccessState extends AuctionStates {}

class AuctionPostImagePickedErrorState extends AuctionStates {}

class AuctionRemovePostImageState extends AuctionStates {}

class AuctionCreatePostLoadingState extends AuctionStates {}

class AuctionCreatePostSuccessState extends AuctionStates {}

class AuctionCreatePostErrorState extends AuctionStates {}

class AuctionGetPostLoadingState extends AuctionStates {}

class AuctionGetPostSuccessState extends AuctionStates {}

class AuctionGetPostErrorState extends AuctionStates {
  final String error;

  AuctionGetPostErrorState(this.error);
}

class AuctionLikePostSuccessState extends AuctionStates {}

class AuctionLikePostErrorState extends AuctionStates {
  final String error;

  AuctionLikePostErrorState(this.error);
}

class AuctionWriteCommentLoadingState extends AuctionStates {}

class AuctionWriteCommentSuccessState extends AuctionStates {}

class AuctionWriteCommentErrorState extends AuctionStates {}

class AuctionGetCommentLoadingState extends AuctionStates {}

class AuctionGetCommentSuccessState extends AuctionStates {}

class AuctionGetCommentErrorState extends AuctionStates {
  final String error;

  AuctionGetCommentErrorState(this.error);
}

class AuctionTicketImagePickedSuccessState extends AuctionStates {}

class AuctionTicketImagePickedErrorState extends AuctionStates {}

class AuctionRemoveTicketImageState extends AuctionStates {}

class AuctionCreateTicketLoadingState extends AuctionStates {}

class AuctionCreateTicketSuccessState extends AuctionStates {}

class AuctionCreateTicketErrorState extends AuctionStates {}

class AuctionGetTicketLoadingState extends AuctionStates {}

class AuctionGetTicketSuccessState extends AuctionStates {}

class AuctionGetTicketErrorState extends AuctionStates {
  final String error;

  AuctionGetTicketErrorState(this.error);
}

class AuctionLikeTicketSuccessState extends AuctionStates {}

class AuctionLikeTicketErrorState extends AuctionStates {
  final String error;

  AuctionLikeTicketErrorState(this.error);
}
