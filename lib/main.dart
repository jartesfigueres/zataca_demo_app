import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_api/json_placeholder_api.dart';

import 'package:zataca_demo_app/app.dart';
import 'package:zataca_demo_app/common/observer/simple_bloc_observer.dart';
import 'package:zataca_demo_app/configuration/theme_configuration.dart';

void main() {
  // Log all the state changes and errors globally
  Bloc.observer = GlobalBlocObserver();
  // Visible on mobile devices
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ThemeConfiguration.primaryColor,
      systemNavigationBarColor: ThemeConfiguration.primaryColor,
    ),
  );
  // Main entry point
  runApp(
    App(
      dataRepository: JSONPlaceholderAPI(),
    ),
  );
}
