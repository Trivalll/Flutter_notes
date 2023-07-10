import 'package:flutter/material.dart';
import 'package:notes/data/hive_database.dart';
import 'note.dart';

class NoteData extends ChangeNotifier {
  //hive database
  final db = HiveDatabase();

  //overal list first note
  List<Note> allNotes = [

  ];

  //initalize list
  void initializeNotes(){
    allNotes = db.loadNotes();
  }

    //get notes
  List<Note> getAllNotes() {
    return allNotes;
  }


  //add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  //update note
  void upgradeNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}