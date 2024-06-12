import 'package:example/domain/tasks_repository/tasks_column.dart';
import 'package:example/domain/tasks_repository/tasks_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:example/data/api/app_error.dart';
import 'package:injectable/injectable.dart';

part 'tasks_state.dart';

@Injectable()
class TasksCubit extends Cubit<TasksState> {
  final TasksRepository _tasksRepository;

  TasksCubit(this._tasksRepository) : super(const TasksState());

  Future loadTasks() async {
    emit(state.copyWith(isLoading: true, resetError: true));
    final result = await _tasksRepository.getTasks();
    result.either((left) {
      emit(state.copyWith(
        isLoading: false,
        error: left,
      ));
    }, (right) async {
      emit(
        state.copyWith(
          isLoading: false,
          resetError: true,
          tasksColumns: right,
        ),
      );
    });
  }

  Future updateDropItem({
    required int listIndex,
    required int itemIndex,
    required int oldListIndex,
    required int oldItemIndex,
  }) async {
    final tasksColumns = state.tasksColumns;
    if (tasksColumns.isEmpty) {
      return;
    }

    final updatedTasksColumns = tasksColumns.map((columm) => columm.copyWith(tasks: columm.tasks.toList())).toList();
    final task = updatedTasksColumns[oldListIndex].tasks[oldItemIndex];
    updatedTasksColumns[oldListIndex].tasks.removeAt(oldItemIndex);
    updatedTasksColumns[listIndex].tasks.insert(itemIndex, task);

    emit(state.copyWith(
      isLoading: true,
      resetError: true,
      tasksColumns: updatedTasksColumns,
    ));

    bool didChangedColumn = false;
    if (listIndex != oldListIndex) {
      final result = await _tasksRepository.updateParentOfTask(
        taskId: task.taskId,
        parentTaskId: updatedTasksColumns[listIndex].parentTaskId,
      );
      if (result.isLeft) {
        emit(
          state.copyWith(
            isLoading: false,
            error: result.left,
            tasksColumns: tasksColumns, //revert back
          ),
        );
        return;
      }
      didChangedColumn = true;
    }

    if (itemIndex != oldItemIndex) {
      final tasksInThisColumn = updatedTasksColumns[listIndex].tasks;
      final indexOfTask = tasksInThisColumn.indexWhere((element) => element.taskId == task.taskId);
      int sortOrder = indexOfTask;
      if ((indexOfTask + 1) < tasksInThisColumn.length) {
        //index not last
        sortOrder = tasksInThisColumn[indexOfTask + 1].order - 1;
      } else if ((indexOfTask - 1) >= 0) {
        //index not first
        sortOrder = tasksInThisColumn[indexOfTask - 1].order + 1;
      }
      final result = await _tasksRepository.updateSortOrderOfTask(
        taskId: task.taskId,
        sortOrder: sortOrder,
      );
      if (result.isLeft) {
        emit(
          state.copyWith(
            isLoading: false,
            error: result.left,
            tasksColumns: didChangedColumn ? null : tasksColumns, //revert back if needed
          ),
        );
        return;
      }
    }

    emit(
      state.copyWith(
        isLoading: false,
        resetError: true,
        tasksColumns: updatedTasksColumns,
      ),
    );
  }
}
