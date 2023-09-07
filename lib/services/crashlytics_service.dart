import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsService {
  static const bool isCrashlyticsActive = false; // !kDebugMode;
  Future setup() async {
    // Not all errors are caught by Flutter. Sometimes, errors are instead caught by Zones.
    // see https://firebase.flutter.dev/docs/crashlytics/usage for more info
    runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      },
      (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
    );
    // To catch errors that happen outside of the Flutter context, install an error listener on the current Isolate:
    // see https://firebase.flutter.dev/docs/crashlytics/usage for more info
    Isolate.current.addErrorListener(
      RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last,
        );
      }).sendPort,
    );
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
      !isCrashlyticsActive,
    );
    _reportUncaughtErrors();
  }

  void logError(
    // [error] value should send as dynamic type
    // ignore: type_annotate_public_apis
    error,
    StackTrace? stackTrace,
  ) {
    if (isCrashlyticsActive) log("[ErrorService] $error $stackTrace");
  }

  void _reportUncaughtErrors() {
    FlutterError.onError = (errorDetails) {
      if (!isCrashlyticsActive) {
        unawaited(
          FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails),
        );
      } else {
        logError(errorDetails.summary, errorDetails.stack);
      }
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      if (!isCrashlyticsActive) {
        unawaited(
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
        );
      } else {
        logError(error, stack);
      }

      return true;
    };
  }
}
