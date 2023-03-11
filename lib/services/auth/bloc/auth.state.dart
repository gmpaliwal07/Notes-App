import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:notes/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateUnitialized extends AuthState {
  const AuthStateUnitialized();
}

class AuthStateRegistring extends AuthState {
  final Exception? exception;
  const AuthStateRegistring(this.exception);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateUserVerification extends AuthState {
  const AuthStateUserVerification();
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;
  const AuthStateLoggedOut({
    required this.exception,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [exception, isLoading];
}
