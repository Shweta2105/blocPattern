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
  const AuthEventLogin(this.email, this.password);
}

class AuthEventSendEMailVerification extends AuthEvents {
  const AuthEventSendEMailVerification();
}

class AuthEventRegister extends AuthEvents {
  final String email;
  final String password;

  const AuthEventRegister(this.email, this.password);
}

class AuthEventShouldRegister extends AuthEvents {
  const AuthEventShouldRegister();
}

class AuthEventForgotPassword extends AuthEvents {
  final String? email;

  const AuthEventForgotPassword({this.email});
}

class AuthEventLogOut extends AuthEvents {
  const AuthEventLogOut();
}
