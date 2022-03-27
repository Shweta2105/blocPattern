import 'package:blocprovider/screens/loginscreen.dart';
import 'package:blocprovider/screens/notes/newnotescreen.dart';
import 'package:blocprovider/service/crud/notes_service.dart';
import 'package:blocprovider/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../enums/menu_acton.dart';
import '../../service/auth/auth_service.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _notesService = NotesService();
    super.initState();
  }

  @override
  void dispose() {
    _notesService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NewNoteScreen.routeName); 
              },
              icon: const Icon(Icons.add)),
          PopupMenuButton<MenuAction>(
              offset: const Offset(0.0, 60.0),
              icon: const Icon(Icons.more_vert_rounded, color: whiteColor),
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
        child: FutureBuilder(
          future: _notesService.getOrCreateUser(email: userEmail),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return StreamBuilder(
                    stream: _notesService.allNotes,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Text('Waiting for your notes.........');
                        default:
                          return const CircularProgressIndicator();
                      }
                    });
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
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
