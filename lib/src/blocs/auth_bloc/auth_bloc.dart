import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wiki_tricky/src/models/api_error.dart';
import 'package:wiki_tricky/src/services/secure_storage_service.dart';
import 'package:wiki_tricky/src/services/api_call/auth_api_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApiService authApiService;
  final SecureStorageService secureStorageService;

  AuthBloc(this.authApiService, this.secureStorageService) : super(AuthState()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<String?> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final authToken = await authApiService.login(event.email, event.password);
      await secureStorageService.saveAuthToken(authToken);
      emit(state.copyWith(status: AuthStatus.success));
      return authToken;
    } on DioException catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error,
          error: ApiError(
              message: e.response?.data['message'] ??
                  "Something went wrong. Try later ...")));
    } on Exception {
      emit(state.copyWith(
          status: AuthStatus.error,
          error: ApiError(message: "Something went wrong. Try later ...")));
    }
    return null;
  }

  Future<void> _onSignUpRequested(
      SignupRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await authApiService.signup(event.email, event.username, event.password);
      emit(state.copyWith(status: AuthStatus.success));
    } on DioException catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error,
          error: ApiError(
              message: e.response?.data['message'] ??
                  "Something went wrong. Try later ...")));
    } on Exception {
      emit(state.copyWith(
          status: AuthStatus.error,
          error: ApiError(message: "Something went wrong. Try later ...")));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    try {
      await secureStorageService.deleteAuthToken();
      emit(state.copyWith(status: AuthStatus.initial));
    } catch (e) {
      emit(state.copyWith(
          //TODO: Handle error
          status: AuthStatus.error));
    }
  }
}
