import 'package:dio/dio.dart' hide Headers;

// ignore: avoid_classes_with_only_static_members
class DioFactory {
  static Dio create({List<Interceptor> interceptors = const [], bool addLogInterceptor = true}) {
    final options = BaseOptions(
      contentType: "application/json",
      headers: {"Authorization": "Bearer 48ab34464a5573519725deb5865cc74c"},
      // validateStatus: (status) {
      //   return ![401, 403, 404, 500].contains(status);
      // },
    );
    final dio = Dio(options);
    dio.interceptors.addAll(interceptors);
    if (addLogInterceptor) {
      dio.interceptors.add(
        logInterceptor(),
      );
    }
    return dio;
  }

  static LogInterceptor logInterceptor() {
    return LogInterceptor(
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    );
  }
}
