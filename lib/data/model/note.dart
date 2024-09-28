class Note {
  String noteId;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Note(
      {
      required this.noteId,
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  Note.formFireStore(Map<String, dynamic> data)
      : this(
          noteId: data['noteId'],
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
          isDone: data['isDone'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'noteId': noteId,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
