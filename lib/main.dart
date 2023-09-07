import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:flutter_flavor_example/config/env/env.dart';
import 'package:flutter_flavor_example/config/env/env_config.dart';
import 'package:flutter_flavor_example/config/env/env_keys.dart';
import 'package:flutter_flavor_example/config/firebase/firebase_options.dart';
import 'package:flutter_flavor_example/services/crashlytics_service.dart';
import 'package:flutter_flavor_example/services/remote_config_service.dart';
import 'package:flutter_flavor_example/services/url_service.dart';
import 'package:flutter_flavor_example/services/version_control/repo/version_control_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  final envKey = FlutterConfig.get(EnvKeys.environment);
  final curEnv = getEnvironment(envKey);
  EnvConfig.curEnv = curEnv;
  await Firebase.initializeApp(
    options: firebaseOptions(curEnv),
  );
  await CrashlyticsService().setup();
  await RemoteConfigService().activate();

  if (!kDebugMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
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
      home: MyHomePage(env: EnvConfig.curEnv),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.env,
  });
  final Env env;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => checkVersion(context),
    );
  }

  checkVersion(BuildContext context) async {
    final isForceUpdateRequired =
        await VersionControlRepo(curEnv: widget.env).check();

    if (isForceUpdateRequired && context.mounted) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update available'),
            content: const Text('Please update application'),
            actions: [
              TextButton(
                onPressed: () async {
                  String storeUrlKey;

                  if (Platform.isIOS) {
                    storeUrlKey = widget.env.iosForceUpdateUrl;
                  } else if (Platform.isAndroid) {
                    storeUrlKey = widget.env.androidForceUpdateUrl;
                  } else {
                    storeUrlKey = "";
                  }
                  final String remoteValue =
                      FirebaseRemoteConfig.instance.getString(storeUrlKey);
                  await UrlService().launchUrl(remoteValue);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference envCollection =
        FirebaseFirestore.instance.collection(widget.env.label.toLowerCase());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Environment: ${widget.env.label}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 50),
            child: FutureBuilder(
              future: envCollection.doc('constants').get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text(
                    "Something went wrong",
                    textAlign: TextAlign.center,
                  );
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return const Text(
                    "Document does not exist",
                    textAlign: TextAlign.center,
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Text(
                    "Firebase Env Name: ${data['title']}",
                    textAlign: TextAlign.center,
                  );
                }

                return const CircularProgressIndicator.adaptive();
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              throw Exception();
            },
            child: const Text('Test Crashlytics'),
          ),
        ],
      ),
    );
  }
}
