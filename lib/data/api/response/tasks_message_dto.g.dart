// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksMessageDto _$TasksMessageDtoFromJson(Map<String, dynamic> json) =>
    TasksMessageDto(
      error: json['error'] as String?,
      warning: json['warning'] as String?,
      info: json['info'] as String?,
    );

Map<String, dynamic> _$TasksMessageDtoToJson(TasksMessageDto instance) =>
    <String, dynamic>{
      'error': instance.error,
      'warning': instance.warning,
      'info': instance.info,
    };
