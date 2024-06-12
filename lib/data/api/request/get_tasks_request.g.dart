// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tasks_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTasksRequest _$GetTasksRequestFromJson(Map<String, dynamic> json) =>
    GetTasksRequest(
      periodStart: json['period_start'] as String,
      periodEnd: json['period_end'] as String,
      periodLey: json['period_key'] as String,
      requestedMoId: (json['requested_mo_id'] as num).toInt(),
      behaviourKey: json['behaviour_key'] as String,
      withResult: json['with_result'] as bool,
      responseFields: json['response_fields'] as String,
      authUserId: (json['auth_user_id'] as num).toInt(),
    );

Map<String, dynamic> _$GetTasksRequestToJson(GetTasksRequest instance) =>
    <String, dynamic>{
      'period_start': instance.periodStart,
      'period_end': instance.periodEnd,
      'period_key': instance.periodLey,
      'requested_mo_id': instance.requestedMoId,
      'behaviour_key': instance.behaviourKey,
      'with_result': instance.withResult,
      'response_fields': instance.responseFields,
      'auth_user_id': instance.authUserId,
    };
