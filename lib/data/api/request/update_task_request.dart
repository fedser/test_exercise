import 'package:json_annotation/json_annotation.dart';

part 'update_task_request.g.dart';

@JsonSerializable()
class UpdateTaskRequest {
  @JsonKey(name: "period_start")
  final String periodStart;
  @JsonKey(name: "period_end")
  final String periodEnd;

  @JsonKey(name: "period_key")
  final String periodLey;

  @JsonKey(name: "indicator_to_mo_id")
  final int taskId;

  @JsonKey(name: "field_name")
  final String fieldName;

  @JsonKey(name: "field_value")
  final int fieldValue;

  @JsonKey(name: "auth_user_id")
  final int authUserId;

  const UpdateTaskRequest({
    required this.periodStart,
    required this.periodEnd,
    required this.periodLey,
    required this.taskId,
    required this.fieldName,
    required this.fieldValue,
    required this.authUserId,
  });

  factory UpdateTaskRequest.fromJson(Map<String, dynamic> json) => _$UpdateTaskRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTaskRequestToJson(this);
}
