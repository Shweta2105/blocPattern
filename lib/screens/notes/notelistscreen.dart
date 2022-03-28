import 'package:blocprovider/service/crud/notes_service.dart';
import 'package:flutter/material.dart';

import '../../utilities/dialog/deletedialog.dart';
import '../../utilities/constants.dart';

typedef NoteCallBack = void Function(DatabaseNote note);

class NoteListScreen extends StatelessWidget {
  final NoteCallBack onDeleteNote;
  final NoteCallBack onTap;
  final List<DatabaseNote> notes;
  const NoteListScreen({
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          onTap: () {
            onTap(note);
          },
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: blackColor),
          ),
          trailing: IconButton(
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  onDeleteNote(note);
                }
              },
              icon: const Icon(Icons.delete)),
        );
      },
    );
  }
}
