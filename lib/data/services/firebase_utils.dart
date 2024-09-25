import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/data/model/my_user.dart';
import 'package:note_app/data/model/note.dart';

class FirebaseUtils {
  static CollectionReference<Note> getNotesCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection('notes')
        .withConverter<Note>(
            fromFirestore: (snapshot, options) =>
                Note.formFireStore(snapshot.data()!),
            toFirestore: (note, options) => note.toFireStore());
  }

  static Future<void> addNoteToFirestore(Note note, String uId) {
    var notesCollection = getNotesCollection(uId);
    DocumentReference<Note> docRef = notesCollection.doc();
    note.noteId = docRef.id;
    return docRef.set(note);
  }

  static Future<void> deleteNoteFromFirestore(String noteId, String uId) {
    return getNotesCollection(uId).doc(noteId).delete();
  }

  static Future<void> editNoteInFirestore(Note note, String uId) {
    return getNotesCollection(uId).doc(note.noteId).update(note.toFireStore());
  }

  static Future<List<Note>> fetchNotes(String uId) async {
    var querySnapshot = await getNotesCollection(uId).get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // static Future<void> editIsDone(Note note, String uId) {
  //   return getNotesCollection(uId).doc(note.noteId).update({'isDone': note.isDone});
  // }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()),
            toFirestore: (user, options) => user.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> fetchUserById(String userId) async {
    DocumentSnapshot<MyUser> userDoc =
        await getUsersCollection().doc(userId).get();
    return userDoc.data();
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapShot = await getUsersCollection().doc(uId).get();
    return querySnapShot.data();
  }
}
