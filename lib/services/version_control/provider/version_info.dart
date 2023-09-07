// ignore: depend_on_referenced_packages
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_flavor_example/config/env/env.dart';
import 'package:flutter_flavor_example/config/env/env_config.dart';
import 'package:flutter_flavor_example/services/package_info_service.dart';

part 'version_info.g.dart';

@riverpod
Future<String> getVersionInfo(GetVersionInfoRef _) async {
  final String appVersionInfo = await PackageInfoService().getVersionInfo();
  final String appBuildInfo = await PackageInfoService().getBuildInfo();
  final envLabel = (EnvConfig.curEnv == Env.prod) ? "" : EnvConfig.curEnv.label;
  return "$appVersionInfo.$appBuildInfo $envLabel";
}
