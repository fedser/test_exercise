// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_task_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTaskRequest _$UpdateTaskRequestFromJson(Map<String, dynamic> json) =>
    UpdateTaskRequest(
      periodStart: json['period_start'] as String,
      periodEnd: json['period_end'] as String,
      periodLey: json['period_key'] as String,
      taskId: (json['indicator_to_mo_id'] as num).toInt(),
      fieldName: json['field_name'] as String,
      fieldValue: (json['field_value'] as num).toInt(),
      authUserId: (json['auth_user_id'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateTaskRequestToJson(UpdateTaskRequest instance) =>
    <String, dynamic>{
      'period_start': instance.periodStart,
      'period_end': instance.periodEnd,
      'period_key': instance.periodLey,
      'indicator_to_mo_id': instance.taskId,
      'field_name': instance.fieldName,
      'field_value': instance.fieldValue,
      'auth_user_id': instance.authUserId,
    };
