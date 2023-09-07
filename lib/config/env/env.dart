enum Env {
  dev("DEV"),
  test("UTEST"),
  prod("PROD");

  const Env(this.label);
  final String label;

  String get iosForceUpdateCurrentVersion {
    switch (this) {
      case Env.dev:
        return "ios_dev_force_update_current_version";
      case Env.test:
        return "ios_test_force_update_current_version";
      case Env.prod:
        return "ios_prod_force_update_current_version";
    }
  }

  String get iosForceUpdateUrl {
    switch (this) {
      case Env.dev:
        return "ios_dev_force_update_store_url";
      case Env.test:
        return "ios_test_force_update_store_url";
      case Env.prod:
        return "ios_prod_force_update_store_url";
    }
  }

  String get androidForceUpdateCurrentVersion {
    switch (this) {
      case Env.dev:
        return "android_dev_force_update_current_version";
      case Env.test:
        return "android_test_force_update_current_version";
      case Env.prod:
        return "android_prod_force_update_current_version";
    }
  }

  String get androidForceUpdateUrl {
    switch (this) {
      case Env.dev:
        return "android_dev_force_update_store_url";
      case Env.test:
        return "android_test_force_update_store_url";
      case Env.prod:
        return "android_prod_force_update_store_url";
    }
  }

  String get isForceUpdateRequired => "force_update_required";
}

Env getEnvironment(String envText) {
  return Env.values.firstWhere(
    (e) => e.label == envText,
    orElse: () => Env.dev,
  );
}
