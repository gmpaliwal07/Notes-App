import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/services/auth/auth_service.dart';
import 'package:notes/services/auth/bloc/auth_bloc.dart';
import 'package:notes/services/auth/bloc/auth_event.dart';
import 'package:notes/services/cloud/cloud_note.dart';

import 'package:notes/services/cloud/firebase_cloud_storage.dart';
import 'package:notes/utilities/dialogs/logout_dialog.dart';
import 'package:notes/view/notes/notes_list_view.dart';
import '../../constants/routes.dart';
import '../../enums/menu_action.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 50, 0, 189),
          title: Text(
            "My Notes",
            style: GoogleFonts.robotoSlab(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  createUpdateNoteRoute,
                );
              },
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                size: 35,
              ),
            ),
            PopupMenuButton<MenuAction>(
              shadowColor: const Color.fromARGB(255, 149, 179, 244),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    }
                    break;
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    value: MenuAction.logout,
                    child: Text("Logout"),
                  )
                ];
              },
            )
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
                  return NotesListView(
                    notes: allNotes,
                    onDeleteNote: (note) async {
                      await _notesService.deleteNote(
                          documentId: note.documentId);
                    },
                    onTap: (note) async {
                      Navigator.of(context)
                          .pushNamed(createUpdateNoteRoute, arguments: note);
                    },
                  );
                } else {
                  return CircularProgressIndicator(
                      color: Colors.deepPurpleAccent.shade200);
                }

              default:
                return CircularProgressIndicator(
                  color: Colors.deepPurpleAccent.shade200,
                );
            }
          },
        ));
  }
}
