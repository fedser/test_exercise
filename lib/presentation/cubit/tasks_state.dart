part of 'tasks_cubit.dart';

class TasksState extends Equatable {
  // final TasksContainer? tasksContainer;
  final List<TasksColumn> tasksColumns;
  final AppError? error;
  final bool isLoading;

  const TasksState({
    this.tasksColumns = const [],
    this.error,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        tasksColumns,
        error,
        isLoading,
      ];

  TasksState copyWith({
    List<TasksColumn>? tasksColumns,
    AppError? error,
    bool? isLoading,
    bool resetError = false,
  }) {
    return TasksState(
      tasksColumns: tasksColumns ?? this.tasksColumns,
      error: resetError ? null : (error ?? this.error),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
