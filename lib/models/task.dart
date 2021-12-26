class TaskBase {
  final int? id;
  final String? title;
  final String? description;

  const TaskBase({
    // required this.id,
    this.id,
    this.title,
    this.description,
  });
}

class Task {
  // const Task(
  //   String? title,
  //   String? description,
  //   int? id,
  // ) : super(id: id, title: title, description: description);

  final int? id;
  final String? title;
  final String? description;

  const Task({
    // required this.id,
    this.id,
    this.title,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
