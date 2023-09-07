// ignore_for_file: public_member_api_docs, sort_constructors_first
class Version {
  const Version(
    this.major,
    this.minor,
    this.patch,
    this.build,
  );

  factory Version.fromText(String text) {
    final List<String> list = text.split(".");
    const versionInfoElementCount = 4;
    try {
      if (list.length == versionInfoElementCount) {
        final version = Version(
          int.parse(list.first),
          int.parse(list[1]),
          int.parse(list[2]),
          int.parse(list[3]),
        );

        return version;
      }

      return const Version(0, 0, 0, 0);
    } on Exception {
      return const Version(0, 0, 0, 0);
    }
  }

  final int major;
  final int minor;
  final int patch;
  final int build;

  bool operator >(Version other) {
    if (major > other.major) {
      return true;
    } else if (major < other.major) {
      return false;
    }
    if (minor > other.minor) {
      return true;
    } else if (minor < other.minor) {
      return false;
    }

    if (patch > other.patch) {
      return true;
    } else if (patch < other.patch) {
      return false;
    }

    if (build > other.build) {
      return true;
    } else if (build < other.build) {
      return false;
    }

    return false;
  }

  bool operator <(Version other) {
    if (major < other.major) {
      return true;
    } else if (major > other.major) {
      return false;
    }
    if (minor < other.minor) {
      return true;
    } else if (minor > other.minor) {
      return false;
    }

    if (patch < other.patch) {
      return true;
    } else if (patch > other.patch) {
      return false;
    }

    if (build < other.build) {
      return true;
    } else if (build > other.build) {
      return false;
    }

    return false;
  }

  @override
  // We need to use == operator for comparing
  // ignore: hash_and_equals, avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! Version) return false;
    if (major != other.major) return false;
    if (minor != other.minor) return false;
    if (patch != other.patch) return false;
    if (build != other.build) return false;

    return true;
  }

  @override
  String toString() {
    return 'V(major: $major, minor: $minor, patch: $patch, build: $build)';
  }
}
