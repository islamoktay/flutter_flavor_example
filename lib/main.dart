import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:flutter_flavor_example/config/env/env.dart';
import 'package:flutter_flavor_example/config/env/env_config.dart';
import 'package:flutter_flavor_example/config/env/env_keys.dart';
import 'package:flutter_flavor_example/config/firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  final envKey = FlutterConfig.get(EnvKeys.environment);
  log('envKey: $envKey');
  final curEnv = getEnvironment(envKey);
  EnvConfig.curEnv = curEnv;
  log('curEnv: $curEnv');
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
    CollectionReference envCollection =
        FirebaseFirestore.instance.collection(env.toLowerCase());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Environment: $env'),
      ),
      body: Center(
        child: FutureBuilder(
          future: envCollection.doc('constants').get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Text("Firebase Env Name: ${data['title']}");
            }

            return const CircularProgressIndicator.adaptive();
          },
        ),
      ),
    );
  }
}
