import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:example/data/api/app_error_code_enum.dart';
import 'package:example/data/api/response/tasks_message_dto.dart';

class AppError extends Equatable {
  final AppErrorCode code;
  final String? message;

  const AppError({
    required this.code,
    this.message,
  });

  static AppError fromException(Object error) {
    if (error is AppError) {
      return error;
    }
    return const AppError.defaultError();
  }

  const AppError.unauthorizedError() : this(code: AppErrorCode.unauthorized);
  const AppError.forbiddenError() : this(code: AppErrorCode.forbidden);
  const AppError.defaultError({String? message})
      : this(
          code: AppErrorCode.defaultCode,
          message: message,
        );

  factory AppError.fromDto(TasksMessageDto dto) {
    final List<String> messages = [];
    if (dto.error.isNotNullOrBlank) {
      messages.add(dto.error!);
    }
    if (dto.warning.isNotNullOrBlank) {
      messages.add(dto.warning!);
    }
    if (dto.info.isNotNullOrBlank) {
      messages.add(dto.info!);
    }
    return AppError.defaultError(message: messages.join("\n"));
  }

  @override
  List<Object?> get props => [
        code,
        message,
      ];
}
