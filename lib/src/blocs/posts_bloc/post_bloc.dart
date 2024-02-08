import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:wiki_tricky/src/services/api_call/post_api_service.dart';
import 'package:wiki_tricky/src/services/secure_storage_service.dart';

import '../../models/api_error.dart';
import '../../models/items/item.dart';
import '../../models/posts/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostApiService postApiService;
  final SecureStorageService secureStorageService;

  PostBloc(this.postApiService, this.secureStorageService) : super(const PostState()) {
    on<GetItems>(_onGetItems);
    on<GetNextItems>(_onGetNextItems);
  }

  Future<void> _onGetItems(GetItems event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      final firstPost = await postApiService.getFirstPostRecords();
      emit(state.copyWith(status:PostStatus.success, currentPost: firstPost, items: firstPost.items));
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
    if (state.status != PostStatus.loading) {
      emit(state.copyWith(status: PostStatus.loading));
      try {
        final nextPost = await postApiService.getNextPagePostRecords(event.page);
        final allItems = List<Item>.from(state.items)..addAll(nextPost.items);
        emit(state.copyWith(status: PostStatus.success, currentPost: nextPost, items: allItems));
      } on DioException catch (e) {
        emit(state.copyWith(
            status: PostStatus.error,
            error: ApiError(
                message: e.response?.data['message'] ?? "Something went wrong during fetching. Try later ...")));
      } on Exception {
        emit(state.copyWith(
            status: PostStatus.error,
            error: ApiError(message: "Something went wrong during fetching. Try later ...")));
      }
    }
  }


}
