import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:example/data/api/response/task_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part "tasks_data_dto.g.dart";

@JsonSerializable()
class TasksDataDto extends Equatable {
  @JsonKey(name: "rows")
  final List<TaskDto> rows;

  const TasksDataDto({
    required this.rows,
  });

  factory TasksDataDto.fromJson(Map<String, dynamic> json) => _$TasksDataDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TasksDataDtoToJson(this);

  String toJsonString() => json.encode(toJson());

  @override
  List<Object?> get props => [
        rows,
      ];
}
