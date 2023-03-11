import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/services/cloud/cloud_note.dart';

import 'package:notes/utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback onTap;
  const NotesListView({
    super.key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgroundImage.png"),
              fit: BoxFit.cover)),
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes.elementAt(index);
          return Card(
            shadowColor: Colors.deepPurpleAccent.shade200,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: ListTile(
              onTap: () {
                onTap(note);
              },
              title: Text(
                note.text,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.robotoSlab(
                  fontSize: 20,
                ),
              ),
              trailing: IconButton(
                onPressed: () async {
                  final shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete) {
                    onDeleteNote(note);
                  }
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color.fromARGB(255, 152, 11, 1),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
