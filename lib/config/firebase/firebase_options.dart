import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_flavor_example/config/env/env.dart';
import 'package:flutter_flavor_example/config/firebase/firebase_options_dev.dart'
    as dev;
import 'package:flutter_flavor_example/config/firebase/firebase_options_prod.dart'
    as prod;
import 'package:flutter_flavor_example/config/firebase/firebase_options_test.dart'
    as test;

FirebaseOptions firebaseOptions(Env env) {
  switch (env) {
    case Env.dev:
      return dev.DefaultFirebaseOptions.currentPlatform;
    case Env.test:
      return test.DefaultFirebaseOptions.currentPlatform;
    case Env.prod:
      return prod.DefaultFirebaseOptions.currentPlatform;
  }
}
