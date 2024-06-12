import 'package:example/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

export 'injector.dart';

class InjectorBuilderWidget extends StatelessWidget {
  final Widget Function(BuildContext context, Injector injector) builder;

  const InjectorBuilderWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Consumer<Injector>(
      builder: (context, value, child) => builder(context, value),
    );
  }
}

class InjectorWidget<T extends Object> extends StatelessWidget {
  final Widget Function(BuildContext context, T value) builder;

  const InjectorWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Consumer<Injector>(
      builder: (context, value, child) => builder(context, value.resolve<T>()),
    );
  }
}
