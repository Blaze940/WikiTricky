part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class CreateComment extends CommentEvent {
  final CommentCreateRequest commentCreateRequest;
  final String authToken;

  CreateComment(this.commentCreateRequest, this.authToken);
}

class UpdateComment extends CommentEvent {
  final CommentUpdateRequest commentUpdateRequest;
  final String authToken;

  UpdateComment(this.commentUpdateRequest, this.authToken);
}

class DeleteComment extends CommentEvent {
  final int comment_id;
  final String authToken;

  DeleteComment(this.comment_id, this.authToken);
}