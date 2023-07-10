import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../models/note_data.dart';
import 'editing_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }
  void createNewNote(){
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    Note newNote = Note(id: id, text: '');

    goNotePage(newNote, true);
  }

  void goNotePage(Note note, bool isNewNote) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditingNotePage(note: note, isNewNote: isNewNote,),));
  }

  //delete note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: createNewNote,
        elevation: 0,
        backgroundColor: Colors.pink[200],
        child: const Icon(Icons.add, color: Colors.grey,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 25.0, top: 75),
          child: Text(
        'Notes',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)
    ),
          ),

          //list of notes
          value.getAllNotes().length == 0
              ? Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(
            child: Text('Nothing here..', style: TextStyle(color: Colors.grey[400]),),
          ),
              )
          : CupertinoListSection.insetGrouped(
            children: List.generate(
              value.getAllNotes().length,
                  (index) => CupertinoListTile(
                      title: Text(value.getAllNotes()[index].text),
                    onTap: () => goNotePage(value.getAllNotes() [index], false),
                    trailing: IconButton(icon: Icon(Icons.delete),
                      onPressed: () => deleteNote(value.getAllNotes()[index]),
                    ),
                  ),
            ),
          ),
      ],
      ),
      ),
    );
  }
}
