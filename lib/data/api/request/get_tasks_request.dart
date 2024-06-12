import 'package:json_annotation/json_annotation.dart';

part 'get_tasks_request.g.dart';

@JsonSerializable()
class GetTasksRequest {
  @JsonKey(name: "period_start")
  final String periodStart;
  @JsonKey(name: "period_end")
  final String periodEnd;

  @JsonKey(name: "period_key")
  final String periodLey;

  @JsonKey(name: "requested_mo_id")
  final int requestedMoId;

  @JsonKey(name: "behaviour_key")
  final String behaviourKey;

  @JsonKey(name: "with_result")
  final bool withResult;

  @JsonKey(name: "response_fields")
  final String responseFields;

  @JsonKey(name: "auth_user_id")
  final int authUserId;

  const GetTasksRequest({
    required this.periodStart,
    required this.periodEnd,
    required this.periodLey,
    required this.requestedMoId,
    required this.behaviourKey,
    required this.withResult,
    required this.responseFields,
    required this.authUserId,
  });

  factory GetTasksRequest.fromJson(Map<String, dynamic> json) => _$GetTasksRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetTasksRequestToJson(this);
}
