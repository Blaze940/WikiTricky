part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loadingGetItems,
  loadingCreatePost,
  loadingUpdatePost,
  loadingDeletePost,
  loadingGetDetailsPost,
  successGetItems,
  successCreatePost,
  successUpdatePost,
  successDeletePost,
  successLoadingGetDetailsPost,
  error,
}

class PostState {
  final PostStatus status;
  final Post? currentPost;
  final ItemDetails? currentPostDetails;
  final List<Item> items;
  final Exception? error;

  const PostState({
    this.status = PostStatus.initial,
    this.currentPost,
    this.currentPostDetails,
    this.items = const [],
    this.error,
  });

  PostState copyWith({
    PostStatus? status,
    Post? currentPost,
    ItemDetails? currentPostDetails,
    List<Item>? items,
    Exception? error,
  }) {
    return PostState(
      status: status ?? this.status,
      currentPost: currentPost ?? this.currentPost,
      currentPostDetails: currentPostDetails ?? this.currentPostDetails,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }
}