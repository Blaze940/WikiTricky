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
  final User? user;


  AuthState({
    this.status = AuthStatus.initial,
    this.error,
    this.user,
  });

  AuthState copyWith({
    AuthStatus? status,
    ApiError? error,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}
