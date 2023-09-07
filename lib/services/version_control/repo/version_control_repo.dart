import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:flutter_flavor_example/config/env/env.dart';
import 'package:flutter_flavor_example/services/package_info_service.dart';
import 'package:flutter_flavor_example/services/version_control/model/version.dart';

class VersionControlRepo {
  VersionControlRepo({
    required this.curEnv,
  });
  final Env curEnv;
  final packageInfoService = PackageInfoService();
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  Future<bool> check() async {
    try {
      final String appVersionInfo = await packageInfoService.getVersionInfo();
      final String appBuildInfo = await packageInfoService.getBuildInfo();
      final Version appVersion = Version.fromText(
        "$appVersionInfo.$appBuildInfo",
      );

      final env = curEnv;
      String versionKey;
      if (Platform.isIOS) {
        versionKey = env.iosForceUpdateCurrentVersion;
      } else if (Platform.isAndroid) {
        versionKey = env.androidForceUpdateCurrentVersion;
      } else {
        versionKey = "";
      }

      final String remoteValue = remoteConfig.getString(versionKey);
      final Version remoteVersion = Version.fromText(remoteValue);
      final bool isUpdateAvailable = appVersion < remoteVersion;

      final bool isUpdateForced =
          remoteConfig.getBool(env.isForceUpdateRequired);

      return isUpdateAvailable && isUpdateForced;
    } catch (e) {
      // No need to care exception in case of checking version failure
      return true;
    }
  }
}
