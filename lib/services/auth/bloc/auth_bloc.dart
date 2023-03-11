import 'package:bloc/bloc.dart';
import 'package:notes/services/auth/auth_provider.dart';
import 'package:notes/services/auth/bloc/auth.state.dart';
import 'package:notes/services/auth/bloc/auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUnitialized(isLoading: true)) {
    //register
    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        try {
          await provider.createUser(
            email: email,
            password: password,
          );
          await provider.sendEmailVerification();
          emit(const AuthStateUserVerification(isLoading: false));
        } on Exception catch (e) {
          emit(AuthStateRegistring(exception: e, isLoading: false));
        }
      },
    );
    // send email verification
    on<AuthEventSendEmailVerification>(
      (event, emit) async {
        await provider.sendEmailVerification();
        emit(state);
      },
    );
    //intialize event
    on<AuthEventIntialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateUserVerification(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(user: user, isLoading: false));
      }
    });
//login
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(
          exception: null, isLoading: true, loadingText: 'Logging in...'));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ));
          emit(const AuthStateUserVerification(isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ));
          emit(AuthStateLoggedIn(user: user, isLoading: false));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
          exception: e,
          isLoading: false,
        ));
      }
    });

    //logout
    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
          exception: e,
          isLoading: false,
        ));
      }
    });
  }
}
