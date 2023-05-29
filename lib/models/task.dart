import 'package:equatable/equatable.dart';

class Task extends Equatable {
  // (Bin mir nicht sicher, ob wir hier Equatable brauchen oder
  // ob es nicht sogar hinderlich ist - mit Equatable werden z.B. Tasks mit
  // demselben Titel als ein einziges Objekt behangelt, was zu komischem
  // Verhalten bei checkboxen u.ä. führen kann)
  final String title;
  final String id;
  final bool isDone;
  bool? isDeleted;

  Task({
    required this.title,
    required this.id,
    required this.isDone,
    this.isDeleted,
  }) {
    // Initial values(oder was ist das?):
    isDeleted ?? false;
  }

  Task copyWith({
    String? title,
    String? id,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      title: title ?? this.title,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? 'Nameless Task',
      id: map['id'] ?? 'taskID',
      isDone: map['isDone'] ?? false,
      isDeleted: map['isDeleted'] ?? false,
    );
  }

  @override
  List<Object?> get props => [
        title,
        id,
        isDone,
        isDeleted,
      ];
}
