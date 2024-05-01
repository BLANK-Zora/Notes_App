import 'package:flutter/material.dart';
import 'package:flutter_application_3/component/drawer.dart';
import 'package:flutter_application_3/component/note_tile.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_application_3/models/note.dart';
import 'package:flutter_application_3/models/note_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Notespage extends StatefulWidget {
  const Notespage({super.key});

  @override
  State<Notespage> createState() => _NotePageState();
}

class _NotePageState extends State<Notespage> {
  // text controller
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // on app start , fetch existing notes
    readNotes();
  }

  // create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        content: TextField(
          controller: textController,
        ),
        actions: [
          // create button
          MaterialButton(
            onPressed: () {
              // add to db
              context.read<NoteDatabase>().addNote(textController.text);

              // clear the controller
              textController.clear();

              // pop the dialog
              Navigator.pop(context);
            },
            child: const Text('Create'),
          )
        ],
      ),
    );
  }

  // read a note
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update a note
  void updateNote(Note note) {
    //prefill the current note text
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Note"),
          content: TextField(
            controller: textController,
          ),
          actions: [
            //update button
            MaterialButton(
              onPressed: () {
                //update note in db
                context
                    .read<NoteDatabase>()
                    .updateNote(note.id, textController.text);

                //clear controller
                textController.clear();

                //pop navigation
                Navigator.pop(context);
              },
              child: const Text("Update"),
            )
          ],
        );
      },
    );
  }

  // delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // note database
    final noteDatabase = context.watch<NoteDatabase>();
    // current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,),

      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //HEADING
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),

          //LIST OF NOTES
          Expanded(
            child: ListView.builder(
                itemCount: currentNotes.length,
                // itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  Note note = currentNotes[index];
                  // List tile UI
                  return NoteTile(
                    text: note.text,
                    onEditPressed: () => updateNote(note),
                    onDeletePressed: () => deleteNote(note.id),);
                }),
          )
        ],
      ),
    );
  }
}
