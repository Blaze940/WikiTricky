part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetItems extends PostEvent {}

class GetNextItems extends PostEvent {
  final int page;

  GetNextItems(this.page);
}

class CreatePost extends PostEvent {
  final PostCreateRequest postCreateRequest;
  final String authToken;

  CreatePost(this.postCreateRequest, this.authToken);
}
