class ModelTodo {
  String id;
  String title;
  int timestamp;
  String subtitle;
  String todoCategoryId;
  bool isCompleted;
  List<String>? subtasks;

  ModelTodo({
    required this.id,
    required this.title,
    required this.todoCategoryId,
    required this.timestamp,
    this.isCompleted = false,
    this.subtitle = '',
    this.subtasks,
  });

  Map toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'isCompleted': isCompleted,
      'todoCategoryId': todoCategoryId,
      'timestamp': timestamp,
      'subtasks': subtasks
    };
  }

  factory ModelTodo.fromJson(Map<dynamic, dynamic> json) {
    return ModelTodo(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      isCompleted: json['isCompleted'] ?? false,
      todoCategoryId: json['todoCategoryId'],
      subtasks: json['subtasks'] ?? [].cast<String>(),
      timestamp: int.tryParse(json['timestamp'].toString()) ?? 0,
    );
  }
}
