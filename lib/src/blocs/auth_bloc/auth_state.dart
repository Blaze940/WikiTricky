part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  error,
}

class AuthState {
  final AuthStatus status;
  final ApiError? error;

  AuthState({
    this.status = AuthStatus.initial,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    ApiError? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
