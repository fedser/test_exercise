import 'package:example/data/api/api_client.dart';
import 'package:example/data/api/dio_factory.dart';
import 'package:injectable/injectable.dart';

abstract class AppURLHelper {
  static String baseUrl() {
    return "https://development.kpi-drive.ru/";
  }

  static String baseApiUrl() {
    return "${baseUrl()}_api/";
  }
}

@module
abstract class ApiModule {
  @Singleton()
  ApiClient apiClient() {
    final dio = DioFactory.create();
    return ApiClient(
      dio,
      AppURLHelper.baseApiUrl(),
    );
  }
}
