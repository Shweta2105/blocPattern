import 'package:blocprovider/screens/registerscreen.dart';
import 'package:blocprovider/service/auth/bloc/auth_bloc.dart';
import 'package:blocprovider/service/auth/bloc/auth_events.dart';
import 'package:blocprovider/service/auth/bloc/auth_state.dart';
import 'package:blocprovider/service/auth/firebase_auth_provider.dart';

import 'package:blocprovider/screens/notes/noteviewscreen.dart';
import 'package:blocprovider/screens/loginscreen.dart';
import 'package:blocprovider/screens/notes/createupdatenotescreen.dart';
import 'package:blocprovider/screens/verifyemail.dart';
import 'package:blocprovider/service/auth/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthService.firebase().initialize();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.orangeAccent,
          fontFamily: 'SansitaSwashed'),

      home:
          //LoginScreen(),
          BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      // RegisterScreen(),
      routes: {
        CreateUpdateNoteScreen.routeName: (context) =>
            const CreateUpdateNoteScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthStateLoggedIn) {
        return NoteViewScreen();
      } else if (state is AuthStateNeedsVerification) {
        return VerifyEmailScreen();
      } else if (state is AuthStateLoggedOut) {
        return LoginScreen();
      } else if (state is AuthStateRegistering) {
        return RegisterScreen();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    });
  }
}
