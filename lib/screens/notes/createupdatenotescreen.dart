import 'package:blocprovider/service/auth/auth_service.dart';
import 'package:blocprovider/utilities/dialog/cannotshareemptydialog.dart';
import 'package:blocprovider/utilities/generics/get_arguments.dart';
import 'package:blocprovider/service/cloud/firebasecloudstorage.dart';
import 'package:blocprovider/service/cloud/cloudexception.dart';
import 'package:blocprovider/service/cloud/cloudnote.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class CreateUpdateNoteScreen extends StatefulWidget {
  static const String routeName = '/createUpdateNote';
  const CreateUpdateNoteScreen({Key? key}) : super(key: key);

  @override
  State<CreateUpdateNoteScreen> createState() => _CreateUpdateNoteScreenState();
}

class _CreateUpdateNoteScreenState extends State<CreateUpdateNoteScreen> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _textEditingController;

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();

    if (widgetNote != null) {
      _note = widgetNote;
      _textEditingController.text = widgetNote.text;
      return widgetNote;
    }
    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;

    final userId = currentUser.id;
    final newNote = await _notesService.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteifTextIsEmpty() {
    final note = _note;
    if (_textEditingController.text.isEmpty && note != null) {
      _notesService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveIfTextNotEmpty() async {
    final note = _note;
    final text = _textEditingController.text;
    if (text.isNotEmpty && note != null) {
      await _notesService.updateNote(documentId: note.documentId, text: text);
    }
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textEditingController.text;
    await _notesService.updateNote(
      documentId: note.documentId,
      text: text,
    );
  }

  void setUpTextControllerListener() {
    _textEditingController.removeListener(_textControllerListener);
    _textEditingController.addListener(_textControllerListener);
  }

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _deleteNoteifTextIsEmpty();
    _saveIfTextNotEmpty();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        actions: [
          IconButton(
              onPressed: () async {
                final text = _textEditingController.text;
                if (_note == null || text.isEmpty) {
                  await showCannotShareEmptyDialog(context);
                } else {
                  Share.share(text);
                }
              },
              icon: const Icon(Icons.share))
        ],
      ),
      body: FutureBuilder(
          future: createOrGetExistingNote(context),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                setUpTextControllerListener();
                return TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(hintText: 'Start typing here...'),
                );
              default:
                return CircularProgressIndicator();
            }
          }),
    );
  }
}
