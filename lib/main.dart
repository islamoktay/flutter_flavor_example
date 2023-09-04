import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:flutter_flavor_example/config/env/env.dart';
import 'package:flutter_flavor_example/config/env/env_config.dart';
import 'package:flutter_flavor_example/config/env/env_keys.dart';
import 'package:flutter_flavor_example/config/firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  final curEnv = getEnvironment(FlutterConfig.get(EnvKeys.environment));
  EnvConfig.curEnv = curEnv;
  await Firebase.initializeApp(
    options: firebaseOptions(curEnv),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Flavor Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(env: EnvConfig.curEnv.label),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.env,
  });
  final String env;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Environment: $env'),
      ),
      body: Center(
        child: Text(
          env,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
