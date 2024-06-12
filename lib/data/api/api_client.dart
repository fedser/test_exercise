import 'package:either_dart/either.dart';
import 'package:example/data/api/app_error.dart';
import 'package:example/data/api/base_api_client_extension.dart';
import 'package:example/data/api/request/get_tasks_request.dart';
import 'package:example/data/api/request/update_task_request.dart';
import 'package:example/data/api/response/get_tasks_response.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, String baseUrl) {
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @MultiPart()
  @POST('indicators/get_mo_indicators')
  Future<GetTasksResponse> _getTasks(
    @Part() Map<String, dynamic> body,
  );

  @MultiPart()
  @POST('indicators/save_indicator_instance_field')
  Future<void> _updateTask(
    @Part() Map<String, dynamic> body,
  );

//   field_name:parent_id
// field_value:311841
// field_name:order
// field_value:2
}

extension OrdersApi on ApiClient {
  Future<Either<AppError, GetTasksResponse>> getTasks() async {
    try {
      const request = GetTasksRequest(
        periodStart: "2024-05-01",
        periodEnd: "2024-05-31",
        periodLey: "month",
        requestedMoId: 478,
        behaviourKey: "task",
        withResult: false,
        responseFields: "name,indicator_to_mo_id,parent_id,order",
        authUserId: 2,
      );
      final apiRequest = _getTasks(request.toJson());
      final result = await BaseApiHelpers.appCallAPI(apiRequest);
      return result;
    } catch (e) {
      debugPrint("Error during api call: $e");
      return const Left(AppError.defaultError());
    }
  }

  Future<Either<AppError, void>> updateTask({
    required int taskId,
    int? parentTaskId,
    int? sortOrder,
  }) async {
    try {
      final request = UpdateTaskRequest(
        periodStart: "2024-05-01",
        periodEnd: "2024-05-31",
        periodLey: "month",
        taskId: taskId,
        fieldName: parentTaskId == null ? "order" : "parent_id",
        fieldValue: parentTaskId ?? (sortOrder ?? 0),
        authUserId: 2,
      );
      final apiRequest = _updateTask(request.toJson());
      final result = await BaseApiHelpers.appCallAPI(apiRequest);
      return result;
    } catch (e) {
      debugPrint("Error during api call: $e");
      return const Left(AppError.defaultError());
    }
  }
}
