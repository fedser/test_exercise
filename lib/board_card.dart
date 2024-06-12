import 'package:example/data/api/response/task_dto.dart';
import 'package:flutter/material.dart';

class BoardCard extends StatelessWidget {
  final TaskDto item;
  final Function onTap;

  const BoardCard({super.key, required this.item, required this.onTap});

  void _handleItemTap() => onTap(item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleItemTap,
      child: Card(
        child: ClipPath(
          clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(item.name, maxLines: 1),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Icon(Icons.supervised_user_circle_outlined)],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
