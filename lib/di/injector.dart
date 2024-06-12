import 'package:example/di/injector.config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

const platformMobile = Environment('platformMobile');
const platformWeb = Environment('platformWeb');

configInjector(
  GetIt getIt, {
  String? env,
  EnvironmentFilter? environmentFilter,
}) {
  return getIt.init(
    environmentFilter: environmentFilter,
    environment: env,
  );
}

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
GetIt configureDependencies() => getIt.init();

class Injector {
  static Injector of(BuildContext context) {
    return Provider.of<Injector>(context, listen: false);
  }

  static final Injector instance = Injector._();

  Injector._();

  Future<GetIt> configure() async {
    // await _initInjectable();
    return configureDependencies();
  }

  T resolve<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    return GetIt.instance.get<T>(instanceName: instanceName, param1: param1, param2: param2);
  }
}
