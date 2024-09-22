class ModelSubtask {
  String id;
  String title;
  bool isCompleted;
  ModelSubtask({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  Map toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory ModelSubtask.fromJson(Map<dynamic, dynamic> json) {
    return ModelSubtask(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}
