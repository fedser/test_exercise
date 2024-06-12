import 'package:example/data/api/response/task_dto.dart';
import 'package:example/di/injector.dart';
import 'package:example/domain/tasks_repository/tasks_column.dart';
import 'package:example/presentation/app_loading_overlay.dart';
import 'package:example/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:example/board_card.dart';
import 'package:flutter/material.dart';

class ExampleBoard extends StatefulWidget {
  const ExampleBoard({super.key});

  @override
  State<ExampleBoard> createState() => _ExampleBoardState();
}

class _ExampleBoardState extends State<ExampleBoard> {
  late final TasksCubit _tasksCubit;
  final _boardViewController = BoardViewController();

  @override
  void initState() {
    _tasksCubit = Injector.instance.resolve<TasksCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tasksCubit.loadTasks();
    });
    super.initState();
  }

  @override
  void dispose() {
    _tasksCubit.close();
    super.dispose();
  }

  void _handleCardTap() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item tap')));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
        bloc: _tasksCubit,
        listener: (context, state) async {
          if (state.error != null) {
            _showDialog(state.error?.message ?? "Ошибка", context);
          }
        },
        builder: (context, state) {
          return AppLoadingOverlay(
            isLoading: state.isLoading,
            child: _mainContent(
              state,
              context,
            ),
          );
        });
  }

  Widget _mainContent(
    TasksState state,
    BuildContext context,
  ) {
    List<BoardList> lists = [];
    final listColumns = state.tasksColumns;
    for (var i = 0; i < listColumns.length; i++) {
      final column = listColumns[i];
      final columnWidget = _createBoardList(i, column);
      //TODO: if count tasks in column changed then need to update badge ()
      lists.add(columnWidget);
    }
    return BoardView(
      lists: lists,
      boardViewController: _boardViewController,
    );
  }

  BoardItem _buildBoardItem(TaskDto itemObject) {
    return BoardItem(
        draggable: true,
        onStartDragItem: (int? listIndex, int? itemIndex, BoardItemState? state) {},
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex, int? oldItemIndex, BoardItemState? state) {
          if (listIndex != null && oldListIndex != null && itemIndex != null && oldItemIndex != null) {
            _tasksCubit.updateDropItem(
              listIndex: listIndex,
              itemIndex: itemIndex,
              oldListIndex: oldListIndex,
              oldItemIndex: oldItemIndex,
            );
          }
        },
        onTapItem: (int? listIndex, int? itemIndex, BoardItemState? state) async {},
        item: BoardCard(item: itemObject, onTap: _handleCardTap));
  }

  BoardList _createBoardList(
    int index,
    TasksColumn column,
  ) {
    final List<BoardItem> items = [];
    for (int i = 0; i < column.tasks.length; i++) {
      items.insert(i, _buildBoardItem(column.tasks[i]));
    }

    return BoardList(
      index: index,
      draggable: false,
      header: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Badge(
                offset: const Offset(12, -4),
                label: Text("${column.tasks.length}"),
                child: Text(column.title, style: const TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
      ],
      items: items,
    );
  }

  Future<void> _showDialog(
    String text,
    BuildContext context,
  ) async {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(text),
        // content: text != null ? Text(text!) : null,
        actions: [
          ElevatedButton(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          )
        ],
      ),
    );
  }
}
