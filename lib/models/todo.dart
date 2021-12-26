class Todo {
  final int? id;
  final int taskId;
  final String? title;
  final int isDone;

  const Todo({
    // required this.id,
    required this.taskId,
    this.id,
    this.title,
    this.isDone = 0,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'isDone': isDone, 'taskId': taskId};
  }
}
