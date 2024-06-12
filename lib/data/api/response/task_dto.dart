import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "task_dto.g.dart";

@JsonSerializable()
class TaskDto extends Equatable {
  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "indicator_to_mo_id")
  final int taskId;

  @JsonKey(name: "parent_id")
  final int parentId;

  @JsonKey(name: "order")
  final int order;

  const TaskDto({
    required this.name,
    required this.taskId,
    required this.parentId,
    required this.order,
  });

  factory TaskDto.fromJson(Map<String, dynamic> json) => _$TaskDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDtoToJson(this);

  String toJsonString() => json.encode(toJson());

  @override
  List<Object> get props => [
        name,
        taskId,
        parentId,
        order,
      ];
}
