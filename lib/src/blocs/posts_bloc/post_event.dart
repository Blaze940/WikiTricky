part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetItems extends PostEvent {}

class GetItemsByUser extends PostEvent {
  final int user_id;

  GetItemsByUser(this.user_id);
}

class GetNextItems extends PostEvent {
  final int page;

  GetNextItems(this.page);
}

class GetNextItemsByUser extends PostEvent {
  final int user_id;
  final int page;

  GetNextItemsByUser(this.user_id, this.page);
}

class GetDetailsPost extends PostEvent {
  final int post_id;

  GetDetailsPost(this.post_id);
}

class CreatePost extends PostEvent {
  final PostCreateRequest postCreateRequest;
  final String authToken;

  CreatePost(this.postCreateRequest, this.authToken);
}

class UpdatePost extends PostEvent {
  final PostUpdateRequest postUpdateRequest;
  final String authToken;

  UpdatePost(this.postUpdateRequest, this.authToken);
}

class DeletePost extends PostEvent {
  final int post_id;
  final String authToken;

  DeletePost(this.post_id, this.authToken);
}




