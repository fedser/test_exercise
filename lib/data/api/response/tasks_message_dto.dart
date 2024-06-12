import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "tasks_message_dto.g.dart";

@JsonSerializable()
class TasksMessageDto extends Equatable {
  @JsonKey(name: "error")
  final String? error;

  @JsonKey(name: "warning")
  final String? warning;

  @JsonKey(name: "info")
  final String? info;

  const TasksMessageDto({
    this.error,
    this.warning,
    this.info,
  });

  factory TasksMessageDto.fromJson(Map<String, dynamic> json) => _$TasksMessageDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TasksMessageDtoToJson(this);

  String toJsonString() => json.encode(toJson());

  @override
  List<Object?> get props => [
        error,
        warning,
        info,
      ];
}
