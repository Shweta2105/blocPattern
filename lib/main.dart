import 'package:blocprovider/screens/homescreen.dart';
import 'package:blocprovider/screens/loginscreen.dart';
import 'package:blocprovider/screens/verifyemail.dart';
import 'package:blocprovider/service/auth/auth_service.dart';
import 'package:flutter/material.dart';

import 'screens/registerscreen.dart';

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
      home: LoginScreen(),
      // RegisterScreen(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        VerifyEmailScreen.routeName: (context) => VerifyEmailScreen(),
      },
    );
  }
}
