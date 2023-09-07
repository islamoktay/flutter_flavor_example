// Service files must access plug-in packages
// ignore_for_file: avoid-banned-imports
import 'package:package_info_plus/package_info_plus.dart';


class PackageInfoService {

  Future<String> getVersionInfo() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();

      return packageInfo.version;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<String> getBuildInfo() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();

      return packageInfo.buildNumber;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
