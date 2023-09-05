# flutter_flavor_example

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


flutterfire config \
  --project=ahmetislam-flutter-flavor \
  --out=lib/firebase/firebase_options_dev.dart \
  --ios-bundle-id=com.ahmetislam.flutterFlavorExample.dev \
  --android-app-id=com.ahmetislam.flutterFlavorExample.dev

flutterfire config \
  --project=ahmetislam-flutter-flavor \
  --out=lib/firebase/firebase_options_test.dart \
  --ios-bundle-id=com.ahmetislam.flutterFlavorExample.utest \
  --android-app-id=com.ahmetislam.flutterFlavorExample.utest

flutterfire config \
  --project=ahmetislam-flutter-flavor \
  --out=lib/firebase/firebase_options_prod.dart \
  --ios-bundle-id=com.ahmetislam.flutterFlavorExample \
  --android-app-id=com.ahmetislam.flutterFlavorExample