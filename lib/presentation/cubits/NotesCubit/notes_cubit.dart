import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/data/services/firebase_utils.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial()) {
    loadNotes();
  }

  Future<void> loadNotes() async {
    emit(NotesLoading());
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        emit(NotesError("User is not logged in."));
        return;
      }
      String userId = currentUser.uid;
      print("Fetching notes for userId: $userId");

      List<Note> notes = await FirebaseUtils.fetchNotes(userId);
      // log('${}');
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> addNote(Note note) async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        emit(NotesError("User is not logged in."));
        return;
      }
      String userId = currentUser.uid;
      // note.noteId = currentUser.uid;
      // String idNote= FirebaseFirestore.instance.
      // collection('users')
      //     .doc(currentUser.uid)
      //     .collection('Note')
      //     .doc()
      //     .id;
      // note.idNote = idNote;
      // await FirebaseFirestore.instance.
      // collection('users')
      //     .doc(currentUser.uid)
      //     .collection('Note').
      // doc(idNote);
      print("Fetching notes for userId: $userId");
      await FirebaseUtils.addNoteToFirestore(note, userId);
      loadNotes();
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        emit(NotesError("User is not logged in."));
        return;
      }
      String userId = currentUser.uid;
      print("Fetching notes for userId: $userId");
      await FirebaseUtils.deleteNoteFromFirestore(noteId, userId);
      loadNotes();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editNote(Note note) async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        emit(NotesError("User is not logged in."));
        return;
      }
      String userId = currentUser.uid;
      await FirebaseUtils.editNoteInFirestore(note, userId);
      loadNotes();
    } catch (e) {
      print(NotesError(e.toString()));
    }
  }

  void updateNoteInList(Note updatedNote) {
    if (state is NotesLoaded) {
      final notes = (state as NotesLoaded).notes;

      final index =
          notes.indexWhere((note) => note.noteId == updatedNote.noteId);
      if (index != -1) {
        notes[index] = updatedNote;

        emit(NotesLoaded(List.from(notes)));
      }
    }
  }

// Future<void> editDone(Note note) async {
//   try {
//     await FirebaseUtils.editIsDone(note, uId);
//     loadNotes();
//   } catch (e) {
//     print(e.toString());
//   }
// }
}
