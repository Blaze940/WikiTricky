part of 'comment_bloc.dart';

enum CommentStatus {
  initial,
  loadingCreateComment,
  loadingUpdateComment,
  loadingDeleteComment,
  successCreateComment,
  successUpdateComment,
  successDeleteComment,
  error,
}

class CommentState {
  final CommentStatus status;
  final Exception? error;

  const CommentState({
    this.status = CommentStatus.initial,

    this.error,
  });

  CommentState copyWith({
    CommentStatus? status,
    Exception? error,
  }) {
    return CommentState(
      status: status ?? this.status,
    );
  }
}