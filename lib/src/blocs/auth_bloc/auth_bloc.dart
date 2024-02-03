import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../services/auth_api_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApiService apiService;

  AuthBloc(this.apiService) : super(AuthState()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignUpRequested);
  }

  Future<String?> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final response = await apiService.login(event.email, event.password);
      //TODO: Gerer succes et cas vide
      emit(state.copyWith(status: AuthStatus.success));
      print("response login bloc: " + response.toString());
      return response.toString();
    } catch (e) {
      //Lancer exception ou retourner quelque chose
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
      final response =
          await apiService.signup(event.email, event.username, event.password);
      //  TODO:Gerer succes et cas vide
      emit(state.copyWith(status: AuthStatus.success));
      print("response signup bloc: " + response.toString());
      return response.toString();
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error, error: Exception('Failed to signup')));
      print("error signup bloc : " + e.toString());
    }
    return null;
  }
}
