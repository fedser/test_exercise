import 'package:example/data/api/response/task_dto.dart';

class TasksColumn {
  final int parentTaskId;
  final String title;
  final List<TaskDto> tasks;

  const TasksColumn({
    required this.parentTaskId,
    required this.title,
    required this.tasks,
  });

  TasksColumn copyWith({
    int? parentTaskId,
    String? title,
    List<TaskDto>? tasks,
  }) {
    return TasksColumn(
      parentTaskId: parentTaskId ?? this.parentTaskId,
      title: title ?? this.title,
      tasks: tasks ?? this.tasks,
    );
  }
}
