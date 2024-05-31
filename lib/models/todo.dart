class ToDo {
  String? id;
  String? ToDoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.ToDoText,
    this.isDone = false,
  });

  static List<ToDo> todolist() {
    return [
    ];
  }
}
