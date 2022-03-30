import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvents {
  const AuthEvents();
}

class AuthEventInitialize extends AuthEvents {
  const AuthEventInitialize();
}

class AuthEventLogin extends AuthEvents {
  final String email;
  final String password;
  const AuthEventLogin(this.email,this.password);
}

class AuthEventLogOut extends AuthEvents{
  const AuthEventLogOut();
}