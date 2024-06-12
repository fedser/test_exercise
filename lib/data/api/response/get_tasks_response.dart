import 'package:json_annotation/json_annotation.dart';

import 'package:example/data/api/response/tasks_data_dto.dart';
import 'package:example/data/api/response/tasks_message_dto.dart';

part 'get_tasks_response.g.dart';

@JsonSerializable()
class GetTasksResponse {
  @JsonKey(name: "MESSAGES")
  final TasksMessageDto message;

  @JsonKey(name: "DATA")
  final TasksDataDto tasksData;

  @JsonKey(name: "STATUS")
  final String status;

  const GetTasksResponse({
    required this.message,
    required this.tasksData,
    required this.status,
  });

  factory GetTasksResponse.fromJson(Map<String, dynamic> json) => _$GetTasksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTasksResponseToJson(this);
}
