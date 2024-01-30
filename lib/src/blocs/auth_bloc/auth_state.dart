part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  error,
}

class AuthState {
  final AuthStatus status;
  final Exception? error;

  AuthState({
    this.status = AuthStatus.initial,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    Exception? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
