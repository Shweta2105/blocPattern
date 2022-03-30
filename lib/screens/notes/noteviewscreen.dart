import 'package:blocprovider/screens/loginscreen.dart';
import 'package:blocprovider/screens/notes/createupdatenotescreen.dart';
import 'package:blocprovider/screens/notes/notelistscreen.dart';
import 'package:blocprovider/service/auth/bloc/auth_events.dart';
import 'package:blocprovider/service/cloud/cloudnote.dart';
import 'package:blocprovider/service/cloud/firebasecloudstorage.dart';
import 'package:blocprovider/service/crud/notes_service.dart';
import 'package:blocprovider/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enums/menu_acton.dart';
import '../../service/auth/auth_service.dart';
import '../../service/auth/bloc/auth_bloc.dart';
import '../../utilities/dialog/logoutdialog.dart';

class NoteViewScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
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
                      context.read<AuthBloc>().add(const AuthEventLogOut());

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
      body: StreamBuilder(
          stream: _notesService.allNotes(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allNotes = snapshot.data as Iterable<CloudNote>;
                  print(allNotes);

                  return NoteListScreen(
                    notes: allNotes,
                    onDeleteNote: (note) async {
                      await _notesService.deleteNote(
                          documentId: note.documentId);
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
          }),
    );
  }
}
