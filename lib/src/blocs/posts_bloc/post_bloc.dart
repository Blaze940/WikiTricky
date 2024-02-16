import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:wiki_tricky/src/models/items/item_details.dart';
import 'package:wiki_tricky/src/models/items/post_update_request.dart';
import 'package:wiki_tricky/src/services/api_call/post_api_service.dart';
import 'package:wiki_tricky/src/services/secure_storage_service.dart';

import '../../models/error/api_error.dart';
import '../../models/items/item.dart';
import '../../models/items/post_create_request.dart';
import '../../models/posts/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostApiService postApiService;
  final SecureStorageService secureStorageService;

  PostBloc(this.postApiService, this.secureStorageService) : super(const PostState()) {
    on<GetItems>(_onGetItems);
    on<GetDetailsPost>(onGetDetailsPost);
    on<GetNextItems>(_onGetNextItems);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
  }

  Future<void> _onGetItems(GetItems event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loadingGetItems));
    try {
      final firstPost = await postApiService.getFirstPostRecords();
      emit(state.copyWith(status:PostStatus.successGetItems, currentPost: firstPost, items: firstPost.items));
    } on DioException catch (e) {
      emit(state.copyWith(
          status: PostStatus.error,
          error: ApiError(
              message: e.response?.data['message'] ??
                  "Something went wrong during fetching. Try later ...")));
    } on Exception {
      emit(state.copyWith(
          status: PostStatus.error,
          error: ApiError(message: "Something went wrong during fetching. Try later ...")));
    }
  }

  Future<void> onGetDetailsPost(GetDetailsPost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loadingGetDetailsPost));
    try {
      final postDetails = await postApiService.getPostDetails(event.post_id);
      emit(state.copyWith(status: PostStatus.successLoadingGetDetailsPost, currentPostDetails: postDetails));
    } on DioException catch (e) {
      emit(state.copyWith(
          status: PostStatus.error,
          error: ApiError(
              message: e.response?.data['message'] ??
                  "Something went wrong during fetching. Try later ...")));
    } on Exception {
      emit(state.copyWith(
          status: PostStatus.error,
          error: ApiError(message: "Something went wrong during fetching. Try later ...")));
    }
  }

  Future<void> _onGetNextItems(GetNextItems event, Emitter<PostState> emit) async {
    if (state.status != PostStatus.loadingGetItems) {
      emit(state.copyWith(status: PostStatus.loadingGetItems));
      try {
        final nextPost = await postApiService.getNextPagePostRecords(event.page);
        final allItems = List<Item>.from(state.items)..addAll(nextPost.items);
        emit(state.copyWith(status: PostStatus.successGetItems, currentPost: nextPost, items: allItems));
      } on DioException catch (e) {
        emit(state.copyWith(
            status: PostStatus.error,
            error: ApiError(
                message: e.response?.data['message'] ?? "Something went wrong during fetch. Try later ...")));
      } on Exception {
        emit(state.copyWith(
            status: PostStatus.error,
            error: ApiError(message: "Something went wrong during fetch. Try later ...")));
      }
    }
  }

  Future<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loadingCreatePost));
    try {
      final postCreateRequestJSON = event.postCreateRequest.toJson();
      await postApiService.createPost(postCreateRequestJSON, event.authToken);
      emit(state.copyWith(status: PostStatus.successCreatePost));
    } on DioException catch (e) {
      emit(state.copyWith(
          status: PostStatus.error,
          error: ApiError(
              message: e.response?.data['message'] ?? "Something went wrong during creation. Try later ...")));
    } on Exception {
      emit(state.copyWith(
          status: PostStatus.error,
          error: ApiError(message: "Something went wrong during creation. Try later ...")));
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loadingUpdatePost));
    try {
      final postUpdateRequestJSON = event.postUpdateRequest.toJson();
      await postApiService.updatePost(postUpdateRequestJSON, event.authToken);
      emit(state.copyWith(status: PostStatus.successUpdatePost));
    } on DioException catch (e) {
      emit(state.copyWith(
          status: PostStatus.error,
          error: ApiError(
              message: e.response?.data['message'] ?? "Something went wrong during update. Try later ...")));
    } on Exception {
      emit(state.copyWith(
          status: PostStatus.error,
          error: ApiError(message: "Something went wrong during update. Try later ...")));
    }
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loadingDeletePost));
    try {
      await postApiService.deletePost(event.post_id, event.authToken);
      emit(state.copyWith(status: PostStatus.successDeletePost));
    } on DioException catch (e) {
      emit(state.copyWith(
          status: PostStatus.error,
          error: ApiError(
              message: e.response?.data['message'] ?? "Something went wrong during deletion. Try later ...")));
    } on Exception {
      emit(state.copyWith(
          status: PostStatus.error,
          error: ApiError(message: "Something went wrong during deletion. Try later ...")));
    }
  }



}
