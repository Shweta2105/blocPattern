import 'package:blocprovider/screens/loginscreen.dart';
import 'package:blocprovider/utils/constants.dart';
import 'package:flutter/material.dart';

import '../enums/menu_acton.dart';
import '../service/auth/auth_service.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          PopupMenuButton<MenuAction>(
              offset: const Offset(0.0, 60.0),
              icon: new Icon(Icons.more_vert_rounded, color: whiteColor),
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogOut = await showLogOutDialog(context);
                    if (shouldLogOut) {
                      await AuthService.firebase().logOut();

                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.routeName, (_) => false);
                    }
                    break;
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(child: Text('LogOut'), value: MenuAction.logout)
                ];
              })
        ],
      ),
      body: Center(
        child: Text('Welcome'),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want Log Out?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Confirm")),
          ],
        );
      }).then((value) => value ?? false);
}
