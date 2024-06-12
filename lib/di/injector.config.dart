// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/api/api_client.dart' as _i3;
import '../domain/tasks_repository/tasks_repository.dart' as _i4;
import '../presentation/cubit/tasks_cubit.dart' as _i5;
import 'modules/api_module.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final apiModule = _$ApiModule();
    gh.singleton<_i3.ApiClient>(() => apiModule.apiClient());
    gh.singleton<_i4.TasksRepository>(
        () => _i4.TasksRepository(gh<_i3.ApiClient>()));
    gh.factory<_i5.TasksCubit>(() => _i5.TasksCubit(gh<_i4.TasksRepository>()));
    return this;
  }
}

class _$ApiModule extends _i6.ApiModule {}
