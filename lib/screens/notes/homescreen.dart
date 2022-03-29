import 'package:blocprovider/screens/loginscreen.dart';
import 'package:blocprovider/screens/notes/createupdatenotescreen.dart';
import 'package:blocprovider/screens/notes/notelistscreen.dart';
import 'package:blocprovider/service/crud/notes_service.dart';
import 'package:blocprovider/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../../enums/menu_acton.dart';
import '../../service/auth/auth_service.dart';
import '../../utilities/dialog/logoutdialog.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email;

  @override
  void initState() {
    _notesService = NotesService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(CreateUpdateNoteScreen.routeName);
              },
              icon: const Icon(Icons.add)),
          PopupMenuButton<MenuAction>(
              offset: const Offset(0.0, 60.0),
              icon: const Icon(Icons.more_vert_rounded, color: whiteColor),
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogOut = await showLogoutDialog(context);
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
                        case ConnectionState.active:
                          if (snapshot.hasData) {
                            final allNotes =
                                snapshot.data as List<DatabaseNote>;
                            print(allNotes);

                            return NoteListScreen(
                              notes: allNotes,
                              onDeleteNote: (note) async {
                                await _notesService.deleteNote(id: note.id);
                              },
                              onTap: (note) {
                                Navigator.of(context).pushNamed(
                                    CreateUpdateNoteScreen.routeName,
                                    arguments: note);
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }

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
