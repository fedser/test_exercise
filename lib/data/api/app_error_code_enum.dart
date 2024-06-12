import 'package:json_annotation/json_annotation.dart';
part "app_error_code_enum.g.dart";

@JsonEnum(alwaysCreate: true)
enum AppErrorCode {
  @JsonValue("unknown")
  unknown,

  @JsonValue("default")
  defaultCode,

  @JsonValue("unauthorized")
  unauthorized,

  @JsonValue("forbidden")
  forbidden,

  @JsonValue("notFound")
  entityNotFound;
}
