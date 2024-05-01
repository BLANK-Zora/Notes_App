import 'package:flutter/foundation.dart';
import 'package:flutter_application_3/models/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
  // Initialise Database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  // List of notes

  final List<Note> currentNotes = [];

  //Create
  Future<void> addNote(String text) async {
    //create new note object
    final newNote = Note()..text = text;

    //save to database
    await isar.writeTxn(() => isar.notes.put(newNote));
    

    //re-read from the db
    fetchNotes();
  }

  //Read
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  //Update
  Future<void> updateNote(int id, String newtext) async {
    final existingNote =
        await isar.notes.get(id); //fetching existing note with its id
    if (existingNote != null) {
      //if not null , then assign new text
      existingNote.text = newtext;
      await isar
          .writeTxn(() => isar.notes.put(existingNote)); // writing transaction
      await fetchNotes();
    }
  }

  //Delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
