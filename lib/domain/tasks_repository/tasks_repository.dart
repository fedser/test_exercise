import 'package:dartx/dartx.dart';
import 'package:either_dart/either.dart';
import 'package:example/data/api/api_client.dart';
import 'package:example/data/api/app_error.dart';
import 'package:example/data/api/response/task_dto.dart';
import 'package:example/domain/tasks_repository/tasks_column.dart';
import 'package:injectable/injectable.dart';

@singleton
class TasksRepository {
  final ApiClient _apiClient;

  const TasksRepository(
    this._apiClient,
  );

  Future<Either<AppError, List<TasksColumn>>> getTasks() async {
    final response = await _apiClient.getTasks();
    if (response.isLeft) {
      return Left(response.left);
    } else {
      final result = response.right;
      if (result.status != "OK") {
        return Left(AppError.fromDto(result.message));
      }
      return Right(
        _fromResponse(
          result.tasksData.rows,
        ),
      );
    }
  }

  static List<TasksColumn> _fromResponse(List<TaskDto> tasksDtos) {
    Map<int, TaskDto> tasksMap = {};
    for (final task in tasksDtos) {
      tasksMap[task.taskId] = task;
    }
    final Set<TaskDto> rootTasks = {};
    for (final task in tasksDtos) {
      if (!tasksMap.containsKey(task.parentId)) {
        rootTasks.add(task);
      }
    }
    final sortedRootTasks = rootTasks.sortedBy((element) => element.order).toList();
    final List<TasksColumn> tasksColumns = [];
    for (final rootTask in sortedRootTasks) {
      final subTasks = tasksDtos
          .where((element) => element.parentId == rootTask.taskId)
          .sortedBy((element) => element.order)
          .toList();
      tasksColumns.add(
        TasksColumn(
          parentTaskId: rootTask.taskId,
          title: rootTask.name,
          tasks: subTasks,
        ),
      );
    }
    return tasksColumns;
  }

  Future<Either<AppError, void>> updateParentOfTask({
    required int taskId,
    required int parentTaskId,
  }) async {
    final response = await _apiClient.updateTask(
      taskId: taskId,
      parentTaskId: parentTaskId,
    );
    if (response.isLeft) {
      return Left(response.left);
    } else {
      return const Right(null);
    }
  }

  Future<Either<AppError, void>> updateSortOrderOfTask({
    required int taskId,
    required int sortOrder,
  }) async {
    final response = await _apiClient.updateTask(
      taskId: taskId,
      sortOrder: sortOrder,
    );
    if (response.isLeft) {
      return Left(response.left);
    } else {
      return const Right(null);
    }
  }
}
