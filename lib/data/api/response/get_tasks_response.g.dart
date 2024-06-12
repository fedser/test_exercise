// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tasks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTasksResponse _$GetTasksResponseFromJson(Map<String, dynamic> json) =>
    GetTasksResponse(
      message:
          TasksMessageDto.fromJson(json['MESSAGES'] as Map<String, dynamic>),
      tasksData: TasksDataDto.fromJson(json['DATA'] as Map<String, dynamic>),
      status: json['STATUS'] as String,
    );

Map<String, dynamic> _$GetTasksResponseToJson(GetTasksResponse instance) =>
    <String, dynamic>{
      'MESSAGES': instance.message,
      'DATA': instance.tasksData,
      'STATUS': instance.status,
    };
