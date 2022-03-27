import 'package:flutter/material.dart';

class NewNoteScreen extends StatefulWidget {
  static const String routeName = '/newNote';
  const NewNoteScreen({Key? key}) : super(key: key);

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
      ),
      body: Center(
        child: const Text('type new note'),
      ),
    );
  }
}
