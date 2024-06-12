import 'package:dio/dio.dart' hide Headers;
import 'package:either_dart/either.dart';
import 'package:example/data/api/app_error.dart';

abstract class BaseApiHelpers {
  static Future<Either<AppError, APIResponse>> appCallAPI<APIResponse>(Future<APIResponse> apiRequest) async {
    try {
      return Right(await apiRequest);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 401) {
        return const Left(AppError.unauthorizedError());
      } else if (statusCode == 403) {
        return const Left(AppError.forbiddenError());
      } else {
        return const Left(AppError.defaultError());
      }
    } catch (e) {
      return Left(AppError.fromException(e));
    }
  }
}
