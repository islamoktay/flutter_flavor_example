import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> activate() async {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 11),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      // No need to care exception in case of activating FirebaseRemoteConfig
      if (kDebugMode) log("FirebaseException: $e");
    }
  }
}
