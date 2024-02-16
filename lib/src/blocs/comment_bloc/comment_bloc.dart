import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:wiki_tricky/src/services/api_call/comment_api_service.dart';
import 'package:wiki_tricky/src/services/secure_storage_service.dart';

import '../../models/error/api_error.dart';
import '../../models/comments/comment_create_request.dart';
import '../../models/comments/comment_update_request.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentApiService commentApiService;
  final SecureStorageService secureStorageService;

  CommentBloc(this.commentApiService, this.secureStorageService)
      : super(const CommentState()) {
    on<CreateComment>(_onCreateComment);
    on<UpdateComment>(_onUpdateComment);
    on<DeleteComment>(_onDeleteComment);
  }

  Future<void> _onCreateComment(
      CreateComment event, Emitter<CommentState> emit) async {
    emit(state.copyWith(status: CommentStatus.loadingCreateComment));
    try {
      final commentCreateRequestJSON = event.commentCreateRequest.toJson();
      await commentApiService.createComment(
          commentCreateRequestJSON, event.authToken);
      emit(state.copyWith(status: CommentStatus.successCreateComment));
    } on DioException catch (e) {
      emit(state.copyWith(
          status: CommentStatus.error,
          error: ApiError(
              message: e.response?.data['message'] ??
                  "Something went wrong during comment posting. Try later ...")));
    } on Exception catch (e) {
      emit(state.copyWith(status: CommentStatus.error, error: e));
    }
  }

  Future<void> _onUpdateComment(
      UpdateComment event, Emitter<CommentState> emit) async {
    emit(state.copyWith(status: CommentStatus.loadingUpdateComment));
    try {
      final commentUpdateRequestJSON = event.commentUpdateRequest.toJson();
      await commentApiService.updateComment(
          commentUpdateRequestJSON, event.authToken);
      emit(state.copyWith(status: CommentStatus.successUpdateComment));
    } on DioException catch (e) {
      emit(state.copyWith(
          status: CommentStatus.error,
          error: ApiError(
              message: e.response?.data['message'] ??
                  "Something went wrong during comment updating. Try later ...")));
    } on Exception {
      emit(state.copyWith(
          status: CommentStatus.error,
          error: ApiError(
              message:
                  "Something went wrong during comment updating. Try later ...")));
    }
  }

  Future<void> _onDeleteComment(
      DeleteComment event, Emitter<CommentState> emit) async {
    emit(state.copyWith(status: CommentStatus.loadingDeleteComment));
    try {
      await commentApiService.deleteComment(event.comment_id, event.authToken);
      emit(state.copyWith(status: CommentStatus.successDeleteComment));
    } on DioException catch (e) {
      emit(state.copyWith(
          status: CommentStatus.error,
          error: ApiError(
              message: e.response?.data['message'] ??
                  "Something went wrong during comment deleting. Try later ...")));
    } on Exception {
      emit(state.copyWith(
          status: CommentStatus.error,
          error: ApiError(
              message:
                  "Something went wrong during comment deleting. Try later ...")));
    }
  }
}
