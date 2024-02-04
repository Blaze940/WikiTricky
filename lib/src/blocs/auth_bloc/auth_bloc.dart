import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wiki_tricky/src/services/secure_storage_service.dart';
import '../../services/auth_api_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApiService apiService;
  final SecureStorageService secureStorageService;

  AuthBloc(this.apiService, this.secureStorageService) : super(AuthState()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<String?> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final token = await apiService.login(event.email, event.password);
      await secureStorageService.saveAuthToken(token);
      emit(state.copyWith(status: AuthStatus.success));
      //print("token login bloc: " + token.toString());
      return token.toString();
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error, error: Exception('Failed to login')));
      print("error login bloc : " + e.toString());
    }

    return null;
  }

  Future<String?> _onSignUpRequested(
      SignupRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final token =
          await apiService.signup(event.email, event.username, event.password);
      await secureStorageService.saveAuthToken(token);
      emit(state.copyWith(status: AuthStatus.success));
      //print("token signup bloc: " + token.toString());
      return token.toString();
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error, error: Exception('Failed to signup')));
      //print("error signup bloc : " + e.toString());
    }
    return null;
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    await secureStorageService.deleteAuthToken();
    emit(state.copyWith(status: AuthStatus.initial));
  }
}
