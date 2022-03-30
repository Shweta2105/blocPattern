import 'package:bloc/bloc.dart';
import 'package:blocprovider/service/auth/auth_provider.dart';
import 'package:blocprovider/service/auth/bloc/auth_events.dart';
import 'package:blocprovider/service/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    //initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut());
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    //login
    on<AuthEventLogin>((event, emit) async {
      emit(const AuthStateLoading());

      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        emit(AuthStateLoggedIn(user!));
      } on Exception catch (e) {
        emit(AuthStateLoginFailure(e));
      }
    });
    //logOut
    on<AuthEventLogOut>((event, emit) async {
      emit(const AuthStateLoading());
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut());
      } on Exception catch (e) {
        emit(AuthStateLogOutFailure(e));
      }
    });
  }
}
