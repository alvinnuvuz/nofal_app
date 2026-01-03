class Todo {
  final int id;
  final int userId;
  final String title;
  final String? description;
  final bool isCompleted;
  final String? createdAt;
  final String? updatedAt;

  Todo({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['is_completed'] == true || json['is_completed'] == 1,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "title": title,
      "description": description,
      "is_completed": isCompleted,
    };
  }
}
