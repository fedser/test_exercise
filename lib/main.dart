import 'dart:async';

import 'package:example/di/injector.dart';
import 'package:example/example_board.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Injector.instance.configure();

    runApp(const MyApp());
  }, (error, StackTrace stackTrace) async {
    // Fimber.e("main error", ex: error, stacktrace: stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Board")),
      body: const ExampleBoard(),
    );
  }
}

class Tab {
  final String label;
  final Widget widget;
  final Widget icon;

  Tab(this.label, this.widget, this.icon);
}
