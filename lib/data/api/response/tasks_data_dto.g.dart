// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksDataDto _$TasksDataDtoFromJson(Map<String, dynamic> json) => TasksDataDto(
      rows: (json['rows'] as List<dynamic>)
          .map((e) => TaskDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TasksDataDtoToJson(TasksDataDto instance) =>
    <String, dynamic>{
      'rows': instance.rows,
    };
