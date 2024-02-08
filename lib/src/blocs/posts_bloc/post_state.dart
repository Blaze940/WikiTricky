part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  success,
  error,
}

class PostState {
  final PostStatus status;
  final Post? currentPost;
  final List<Item> items;
  final Exception? error;

  const PostState({
    this.status = PostStatus.initial,
    this.currentPost,
    this.items = const [],
    this.error,
  });

  PostState copyWith({
    PostStatus? status,
    Post? currentPost,
    List<Item>? items,
    Exception? error,
  }) {
    return PostState(
      status: status ?? this.status,
      currentPost: currentPost ?? this.currentPost,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }
}