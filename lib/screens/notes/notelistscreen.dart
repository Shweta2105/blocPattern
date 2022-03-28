import 'package:blocprovider/dialog/deletedialog.dart';
import 'package:blocprovider/service/crud/notes_service.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

typedef DeleteNoteCallBack = void Function(DatabaseNote note);

class NoteListScreen extends StatelessWidget {
  final DeleteNoteCallBack onDeleteNote;
  final List<DatabaseNote> notes;
  const NoteListScreen({
    required this.notes,
    required this.onDeleteNote,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: blackColor),
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
